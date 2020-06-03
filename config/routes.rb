Rails.application.routes.draw do
  devise_for :tuteurs
  resources :blogs
  resources :epreuves
  resources :messages
  resources :problemes
  #get 'people/search'


  resources :documents
  resources :comments
  resources :classe_matieres
  root 'welcome#index'

  # for help
  get 'yelp', to: "home_student#help"

  scope :nalos do
    get 'services', to: 'welcome#services'
    get 'actualites', to: 'welcome#actualites'
  end


  resources :local_news
  resources :teacher_classes
  resources :matieres
  get 'admin/index'
  resources :courses
  resources :filieres
  get 'home_student/index'
  #devise_for :students
  devise_for :students, controllers: { sessions: 'student/sessions' }
  resources :cycle_ecoles
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :roles
  resources :salle_de_classes
  resources :enseignements
  resources :structures
  get 'home/index'
  #root 'home#index'

  post 'importation', to: 'home#importation'

  scope :teacher do
    get 'apprenant', to: 'home#apprenants'
    get 'salle_classe', to: 'home#classes'
    get 'inside_classe', to: 'home#go_to_classe'
    match 'send_sms_notification_to_classe', to: 'home#send_sms_notification_to_classe', via: [:post, :get] # send notification to classeroom
    get 'apprenant_details', to: 'home#apprenant_details'
    get 'student_par_classe', to: 'home#student_par_classe'
    get 'student_par_filiere', to: 'home#student_par_filiere'
    get 'dashboard', to: 'home#dashboard'
    get 'discuss', to: 'home#discuss'

    scope :discus do
      get "discus_chat", to: "home#discus_chat"
      get "discus_video", to: "home#discus_video"
      get "discus_schedul", to: "home#discus_schedul"
    end

    scope :blog do
      get "blog_index", to: "home#blog_index"
    end

    get 'planning', to: 'home#planning'

    # gestion des elements du dashboard
    scope :dashboard do
      get 'course_dash', to: "home#course_dash"
      get 'epreuves_dash', to: "home#epreuve_dash"
      get 'documents_dash', to: "home#document_dash"
    end

    #gestion des epreuves
    scope :epreuves do
      get 'epreuve', to: 'home#epreuves'
    end

    scope :messagerie do
      get 'msg', to: 'home#messagerie'
      get 'read_message', to: 'home#read_message'
    end

    # gestion des live course
    scope :live_course do
      get 'live_course/index'
      get 'test_webrtc', to: 'live_course#test_webrtc'
    end

    # document sections
    scope :documents do
      get 'detail_content', to: 'documents#detail_content'
      get 'join_to_course', to: 'documents#join_to_course'
      post 'create_course_from_document', to: 'documents#create_course_from_document'
      get 'preview_course', to: 'documents#preview_course'
    end
  end
  # admin scope
  scope :admin do
    get "index", to: "admin#index"
    root "admin#index", as: 'admin_route'
    get 'set_role', to: "admin#set_role"
    get 'set_role_root', to: 'admin#set_role_root'

    # setup plateforme
    scope :setup do
      # liste des apprenants
      get 'setup_liste_apprenants', to: 'setup#liste_apprenants'

      # setup index
      get 'setup_index', to: "setup#index"
      get 'setup_enseignant_index', to: "setup#enseignant_index"
      get 'setup_manage_enseignant_index', to: 'setup#manage_enseignant_index'
      match 'setup_new_teacher', to: 'setup#new_teacher', via: [:post, :patch, :delete] # ajuoter un nouvel enseignant
      get 'setup_student_index', to: "setup#student_idenx"
      get 'setup_notification_index', to: "setup#notification_index"
      get 'setup_course_index', to: "setup#course_index"
      match 'manage_matiere', to: 'setup#manage_matiere', via: [:post, :get, :delete]
      get 'setup_structure_list'  , to: "setup#structure_list"
      get 'setup_structure_index', to: "setup#structure_index"
      get 'setup_manage_structure_index', to: 'setup#manage_structure_index' # permet de manager un structure
      match 'setup_add_new_structure', to: "setup#new_structure", via: [:post, :get, :delete] # ajout d'une nouvelle strcture
      post 'setup_update_structure', to: 'setup#update_structure' # update structure
      get 'setup_droits_index', to: "setup#droits_index"
      get 'setup_root_structure', to: "setup#root_structure" # gestion des utilisateurs root
      get 'setup_new_root_select', to: 'setup#new_root_select' # lister les utilisateurs qui seront les prochains root
      post 'setup_enseignant_root_role', to: 'admin#enseignant_root_role'

      # gestion des aspects liés aux matiere de la plateforme
      get 'setup_matiere_index', to: 'setup#matiere_index'
      match 'setup_new_matiere', to: 'setup#new_matiere', via: [:post, :get, :delete, :patch]
      # fin de la gestion des matiere

      # affectation
      get 'affectation_details', to: 'teacher_classes#details'
      delete 'delete_affectation', to: 'teacher_classes#delete_affectation'


      # gestion de la partie liés au notifications

      # finc de la gestion des notifications
    end

    scope :courses do
      get "course_all", to: "admin#course_all"
      get "course_detail", to: 'admin#course_detail'
      get "course_detail_contact_teacher", to: "admin#course_detail_contact_teacher"
      get "course_send_teacher_note", to: "admin#course_send_teacher_note"

      # course validation
      scope :validation do
        post 'course_validation', to: 'admin#course_validation'
        get 'course_suspension', to: "admin#course_suspension"
        post 'course_validate_or_suspend_all', to: "admin#course_validate_or_suspend_all"
      end
    end

    scope :documents do
      get 'document_all', to: 'admin#document_all'
    end

    # Managing account
    scope :account do
      get 'accounts', to: 'admin#accounts'

      # Managing matieres
      scope :matieres do
        get 'index_matieres', to: 'admin#matieres'
      end

      scope :enseignants do
        get 'index_enseignants', to: 'admin#enseignants'
        get 'teachers', to: 'admin#teachers'
      end

      scope :salle_classes do
        get 'index_salle_classes', to: 'admin#salle_classes'
      end


      # import account information
      scope :import do
        get 'import_teacher', to: 'admin#import_teacher'
        post 'import_teacher_intent', to: 'admin#import_teacher_intent'
        get 'import_student', to: 'admin#import_student'
        post 'import_student_intent', to: 'admin#import_student_intent'

        # matiere import
        post 'import_matiere_intent', to: 'admin#import_matiere_intent'
        match 'import_matiere_form', to: "admin#import_matiere_form", via: [:get, :post]

        # enseignant import
        post 'import_enseignant_intent', to: 'admin#import_enseignant_intent'

        # salle de classe
        post 'import_salle_classe_intent', to: 'admin#import_salle_classe_intent'
      end
    end
  end

  # course for student
  scope :course do
    # search tags for a course
    get 'course_tags', to: 'courses#list_course_tags'

    # students actions
    get "read_course", to: "home_student#read_course"
    get 'read_course_file', to: "home_student#read_course_file"
    get "list_course", to: "home_student#list_course"
    get "read_matiere", to: "home_student#read_matiere"
    get "my_dashboard", to: "home_student#dashboard"
    get "exercice", to: "home_student#exercice"
    get "synthese", to: "home_student#synthese"
    get 'documents', to: "home_student#documents"
    get 'ma_classe', to: "home_student#salle_de_classe"
    get 'my_courses', to: "home_student#student_course" # list student course
    get 'my_courses_files', to: "home_student#student_course_files" #list student course files
    get 'my_teachers', to: "home_student#my_teachers"
    get 'student_ressources', to: 'home_student#student_ressources'
    get 'student_discuss', to: "home_student#discuss"
    get 'time_table', to: 'home_student#time_table'
    post 'student_comment', to: 'home_student#student_comment'

    scope :teacher do
      get 'my_teacher_course', to: 'home_student#my_teacher_course'
    end

    # gestion des epreuves
    scope :epreuves do
      get 'index_epreuves', to: "home_student#student_epreuves"
      get 'read_epreuve', to: 'home_student#read_epreuve'
      get 'read_response', to: 'home_student#read_response'
    end

    # gestion des matieres
    scope :matieres do
      get 'index_matiere', to: "home_student#student_matires"
    end
  end

  # import document xls
  scope :file do
    post 'import', to: 'admin#import'
    post 'set_import', to: 'admin#set_import'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
