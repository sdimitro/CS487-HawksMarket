Hawksmarket::Application.routes.draw do
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"

  get "/report", to: "pages#report", as: "report"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  get 'tags/:tag', to: 'pages#posts', as: :tag

  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"

	resources :interest_posts, only: [:create, :destroy]

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

end
