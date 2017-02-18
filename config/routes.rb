Rails.application.routes.draw do
  scope '/api' do
    scope 'v1' do
      resources :users
      resources :groups
      post 'add_member' => 'groups#add_member'
    end
  end
  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
