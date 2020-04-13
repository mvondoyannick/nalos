Rails.application.routes.draw do
  resources :comments
  resources :classe_matieres
  root 'welcome#index'
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
    get 'apprenant_details', to: 'home#apprenant_details'
    get 'student_par_classe', to: 'home#student_par_classe'
    get 'student_par_filiere', to: 'home#student_par_filiere'
    get 'dashboard', to: 'home#dashboard'
    get 'discuss', to: 'home#discuss'
    get 'planning', to: 'home#planning'
  end
  # admin scope
  scope :admin do
    get "index", to: "admin#index"
    root "admin#index", as: 'admin_route'
  end

  # course for student
  scope :course do
    get "read_course", to: "home_student#read_course"
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
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
