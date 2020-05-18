Rails.application.routes.draw do
  resources :epreuves
  resources :messages
  resources :problemes
  #get 'people/search'


  resources :documents
  resources :comments
  resources :classe_matieres
  root 'welcome#index'

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
  scope :teacher do
    get 'apprenant', to: 'home#apprenants'
    get 'salle_classe', to: 'home#classes'
    get 'inside_classe', to: 'home#go_to_classe'
    get 'apprenant_details', to: 'home#apprenant_details'
    get 'student_par_classe', to: 'home#student_par_classe'
    get 'student_par_filiere', to: 'home#student_par_filiere'
    get 'dashboard', to: 'home#dashboard'
    get 'discuss', to: 'home#discuss'
    get 'planning', to: 'home#planning'

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

    scope :courses do
      get "course_all", to: "admin#course_all"
      get "course_detail", to: 'admin#course_detail'

      # course validation
      scope :validation do
        post 'course_validation', to: 'admin#course_validation'
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

        # enseignant import
        post 'import_enseignant_intent', to: 'admin#import_enseignant_intent'

        # salle de classe
        post 'import_salle_classe_intent', to: 'admin#import_salle_classe_intent'
      end
    end
  end

  # course for student
  scope :course do
    get "read_course", to: "home_student#read_course"
    get "read_matiere", to: "home_student#read_matiere"
    get "my_dashboard", to: "home_student#dashboard"
    get "exercice", to: "home_student#exercice"
    get "synthese", to: "home_student#synthese"
    get 'documents', to: "home_student#documents"
    get 'ma_classe', to: "home_student#salle_de_classe"
    get 'my_courses', to: "home_student#student_course"
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
