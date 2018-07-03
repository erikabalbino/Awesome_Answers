Rails.application.routes.draw do

  # `resource` is singular instead of `resources`.
  # Unlike `resources`, `resource` will create routes
  # that do CRUD operation on only one thing. There
  # will be no index routes and no route will
  # have a `:id` wild card. When using a singular resource,
  # the controller must still be plural.
  resource :session, only: [:new, :create, :destroy]  

  resources :users, only: [:new, :create]

  # /questions/:question_id/answers
  resources :questions do
    # get :my_route
    resources :answers, only: [:create, :destroy]
  end

  # The above method call `resources :questions`
  # will exactly create all RESTful routes as written below:

  #Routes for QuestionsController
  # get "/questions/new", to: "questions#new", as: :new_question
  # post "/questions", to: "questions#create", as: :questions
  # get "/questions/:id", to: "questions#show", as: :question
  # get "/questions", to: "questions#index"
  # get "/questions/:id/edit", to: "questions#edit", as: :edit_question
  # patch "/questions/:id", to: "questions#update"
  # put "/questions/:id", to: "questions#update"
  # delete "/questions/:id", to: "questions#destroy"

  # we map HTTP verb/url combo to a controller#action 
  # (action is a method inside the controller class)

  get('/', {to: 'welcome#index', as: 'home'})

  get('/contact', {to: 'contact#index'})

  post('/contact_submit', {to: 'contact#create'})

end
