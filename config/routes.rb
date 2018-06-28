Rails.application.routes.draw do

  #Routes for QuestionsController
  get "/questions/new", to: "questions#new", as: :new_question
  post "/questions", to: "questions#create", as: :questions
  get "/questions/:id", to: "questions#show", as: :question
  get "/questions", to: "questions#index"
  get "/questions/:id/edit", to: "questions#edit", as: :edit_question
  patch "/questions/:id", to: "questions#update"
  put "/questions/:id", to: "questions#update"
  delete "/questions/:id", to: "questions#destroy"

  # we map HTTP verb/url combo to a controller#action 
  # (action is a method inside the controller class)

  get('/', {to: 'welcome#index', as: 'home'})

  get('/contact', {to: 'contact#index'})

  post('/contact_submit', {to: 'contact#create'})

end
