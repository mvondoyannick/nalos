module CoreTeacher

  class Modifications

    def self.update_pwd(argv)
      t_token = argv[:t_token]
      default_pwd = argv[:default_pwd]

      # search teacher existance
      if User.exists?(role_id: Role.find_by_name('teacher').id, token: t_token)
        current_teacher = User.find_by_token(t_token)

          # authenticate user
        if current_teacher.statut == 'active' && current_teacher.deleted == nil
          # update password
          if current_teacher.update(password: default_pwd)

            # send SMS to teacher
            # current_teacher.phone1
            SmsJob.set(wait: 5.seconds).perform_later(phone: current_teacher.phone1, msg: "Mr/Mme #{current_teacher.name.upcase}, le mot de passe de votre compte a été reinitialisé, votre mot de passe par defaut est maintenant 123456. Merci de le changer dès que possible.", structure: current_teacher.structure.name)

            # return infirmation success
            return true, "Mot de passe de Mr/Mme #{current_teacher.name.upcase} correctement réinitialiser au mot de passe par defaut!"

          else

            puts "Impossible de modifier le mot de passe de Mr/Mme #{current_teacher.name}"
            return true, "Impossible de modifier le mot de passe de Mr/Mme #{current_teacher.name}"

          end

        else

          puts "Impossible de modifier le mot de passe, cet enseignant semble etre suspendu ou supprimé."
          return true, "Impossible de modifier le mot de passe. Merci de lever la suspenssion de cet enseignant."

        end

      else

        return false, "Impossible de trouver cet enseignant"

      end

    end

    # suspend teacher to course by mouving this teacher to new table
    def self.suspend(argv)

    end

    # remove suspension
    def self.unsuspend(argv)

    end

  end

end