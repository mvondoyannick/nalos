class CourseSaveJob < ApplicationJob
  queue_as :default

  def perform(args)
    # Do something later
    @current_user = args[:data][:user_id]
    @current_structure = args[:data][:structure_id]
    @current_file = args[:data][:file_id]
    @current_document = args[:data][:document_id]
    @current_course_status = args[:data][:course_status_id]
    @current_matiere = args[:data][:matiere_id]
    @current_chapter = args[:data][:chapter]
    @current_categorie = args[:data][:categorie]
    @current_tag = args[:data][:tag]
    @current_extrait = args[:data][:extrait]

    # current user
    @u_id = args[:user_id]
    args[:classes_ids].each do |classe_id|
      puts "liste des classe #{classe_id}"
      unless classe_id.nil?
        @course = Course.new(
          user_id: @current_user,
          file_id: @current_file,
          document_id: @current_document,
          course_status_id: @current_course_status,
          matiere_id: @current_matiere,
          chapter: @current_chapter,
          salle_de_class_id: classe_id.to_i,
          categorie: @current_categorie,
          tag: @current_tag,
          extrait: @current_extrait,
          structure_id: @current_structure
        )
        if @course.save
          # enregistrer une notification dans la bd
          puts "Saved new course"
          # ActionCable.server.broadcast('notification_channel', "La leçon #{@course.chapter} à été correctement publiée")
          # CoursesController.render :index , assigns: { course: Course.last }

          # Send notifications to admin of this structure
          User.where(role_id: Role.find_by_name('admin').id, structure_id: @current_structure).each do |admin|
            SmsJob.set(wait: 2.seconds).perform_later(phone: admin.phone1, message: "Bonjour Administrateur #{admin.name.complete_name}, un #{@current_categorie} ayant pour libellé #{@current_chapter.upcase} pour la salle de classe #{SalleDeClass.find(classe_id.to_i).name} (#{Structure.find(@current_structure).name.upcase}) concernant la matière #{Matiere.find(@current_matiere).name} vient d'etre publié et necessite votre attention pour validation. Connectez-vous sur http://elearning.nalschool.com/users/sign_in ")
          end

          @comment = Comment.new(
            course_id: @course.id,
            student_id: User.find_by_matricule('05I022IU').id,
            user_id: @u_id,
            content: ActionText::Content.new("Mr/Mme #{User.find(@current_user).complete_name}, votre leçon #{@current_chapter.upcase} publiée pour la classe #{SalleDeClass.find(classe_id).name.upcase}  vient d'être publiée mais reste en attente de validation.")
          )

          if @comment.save
            puts "new message saved!"
          else
            puts "some errors : #{@comment.errors.details}"

          end

          # SmsJob.perform_now(phone: User.find(@current_user).phone1, msg: "Mr/Mme #{User.find(@current_user).complete_name}, votre leçon #{@current_chapter.upcase} publiée pour la classe #{SalleDeClass.find(classe_id).name.upcase}  vient d'être publiée mais reste en attente de validation.", structure: User.find(@current_user).structure.name.upcase)
        else

          # une erreur est survenu durant la publicatioin
          # ActionCable.server.broadcast('notification_channel', "La leçon #{@course.chapter} n'à pas été correctement publiée \nL'erreur est #{@course.errors.details}")
          puts "Une erreur est survenue : #{@course.errors.details}"
          @comment = Comment.new(
            course_id: @course.id,
            student_id: Student.first.id,
            user_id: @u_id,
            content: ActionText::Content.new("Mr/Mme #{User.find(@current_user).complete_name}, votre leçon #{@current_chapter.upcase} n'a pas pu etre publiée pour les raisons suivantese #{@course.errors.details}. Merci de corriger ce problème et de refaire votre publication.")
          )

          if @comment.save
            puts "Tout va bien, message sauvegardé"
          else
            puts "Une erreur est survenue : #{@comment.errors.details}"
          end
        end
      end
    end
  end
end
