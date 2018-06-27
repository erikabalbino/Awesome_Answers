Rails.application.routes.draw do
  # we map HTTP verb/url combo to a controller#action 
  # (action is a method inside the controller class)

  get('/', {to: 'welcome#index', as: 'home'})

  get('/contact', {to: 'contact#index'})

  post('/contact_submit', {to: 'contact#create'})

end
