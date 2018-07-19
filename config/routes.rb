Rails.application.routes.draw do

  # http://localhost:3000/api/v1/questions

  # The option `defaults: { format: :json }` will set
  # "json" as the default response format for all routes
  # contained within the block of the namespace.

  namespace :api, defaults: { format: :json } do
    # /api...
    namespace :v1 do
      # /api/v1...
      resources :questions
        # /api/v1/questions
      resource :session, only: [:create, :destroy]
        # /api/v1/session
    end
  end

  match(
    "/delayed_job", 
    to: DelayedJobWeb, 
    anchor: false, 
    via: [:get, :post]
  )

  # Rails routes will route path & url methods
  # get(:thing, as: :thing) <-- Creates the following methods
  # thing_path # return "/thing"
  # thing_url # return "http://localhost:3000/thing"

  resources :job_posts, only:[:new, :create, :show, :destroy, :update]

  # /admin/...
  namespace :admin do
    # The `namespace` method takes a symbol as a first argument
    # and a block. It will prefix the symbol's name to the
    # path of all routes defined inside the block.
    # GET /admin/dashboard
    
    resources :dashboard, only: [:index]

    # It will expect that the controllers for the routes
    # inside block to be contained in a module named after
    # the symbol.
    # Example: Admin::DashboardController

    # It will also expect the controllers to be in a sub-directory
    # named after the symbol.
    # Example: /app/controllers/admin/dashboard_controller.rb

    # GET /admin/users
    # POST /admin/users
    # GET /admin/users/:id
    # resources :users
  end

  # `resource` is singular instead of `resources`.
  # Unlike `resources`, `resource` will create routes
  # that do CRUD operation on only one thing. There
  # will be no index routes and no route will
  # have a `:id` wild card. When using a singular resource,
  # the controller must still be plural.
  resource :session, only: [:new, :create, :destroy]  

  resources :users, only: [:new, :create]

  # Here I want create nested routes for votes on answers
  # without creating any of the resources for answers themselves,
  # because the routes for answers are already as nested
  # routes of the question resource.

  # If `shallow: true` is put on the parent resource,
  # all children resources will also be shallow.
  resources :answers , shallow: true, only: [] do
    resources :votes, only: [:create, :update, :destroy]
  end

  # /questions/:question_id/answers
  resources :questions do
    # get :my_route
    resources :answers, only: [:create, :destroy]
    
    # /questions/liked
    # Use the "on:" argument to specify how a nested route
    # behaves relative to its parent.

    # `on: :collection` means that it should act upon the
    # entire collection like the `new` action.

    # `on: :member` means it should act on a single instance
    # of the collection (a member) like the `edit` action.
    get :liked, on: :collection
    resources :likes, shallow: true, only: [:create, :destroy]

    # The `shallow: true` option will seperate routes
    # that require the parent from routes that don't.
    # Routes that require the parent resource will not
    # change. Routes that don't require parent will have
    # the parent of the url and generated method.

    # This means that the index, new and create routes are
    # unaffected. 

    # The show, edit, update and destroy methods will
    # routes will be created as if they do not have a parent.

    # Example:
    # - /questions/10/likes/10/edit becomes /likes/10/edit
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
