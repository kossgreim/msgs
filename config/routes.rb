Msgs::Application.routes.draw do
  resources :friendships
  resources :messages
  resources :user_conversations, :controller => "user_conversations" do
    resources :messages
    member do
      post :mark_as_read
      post :mark_as_unread
      post :user_conversations
    end
  end
  post "user_conversations/:user_conversation_id/messages(.:format)" => "messages#create", as: "create_message" 
  get "users", to: "users#index"
  
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
  post "friends", to: "friendships#destroy"
  get "friends/delete_request", to: "friendships#delete_friend_request"
  get "friends/accept_request", to: "friendships#accept_friend_request"

  #url like site.com/username
  get ":user_name", to: "users#show", as: "user_profile"

  scope ":user_name" do
      get '', to: 'users#show'
  end

end
