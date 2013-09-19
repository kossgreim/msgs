Msgs::Application.routes.draw do
  resources :friendships
   
  resources :user_conversations, :controller => "user_conversations" do
    resources :messages
    member do
      post :mark_as_read
      post :mark_as_unread
    end
  end
  get "users", to: "users#index"
  post "mark_as_read_conversation", to: "user_conversations#mark_as_read"

  root "users#index"
  devise_for :users
  
  devise_scope :user do 
    get "sign_in", to: "devise/sessions#new"
    post "sign_in", to: "devise/sessions#create"
    get "sign_up", to: "devise/registrations#new"
    post "sign_up", to: "devise/registrations#create"
    get "sign_out", to: "devise/sessions#destroy"
  end

  get "friends", to: "friendships#index"

  #url like site.com/username
  scope ":user_name" do
      get '', to: 'users#show'
  end

end
