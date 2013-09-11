Msgs::Application.routes.draw do
  devise_for :users
  
  devise_scope :user do 
    get "sign_in", to: "devise/sessions#new"
    post "sign_in", to: "devise/sessions#create"
    get "sign_up", to: "devise/registrations#new"
    post "sign_up", to: "devise/registrations#create"
    get "sign_out", to: "devise/sessions#destroy"
  end

end
