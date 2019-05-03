Rails.application.routes.draw do
  resources :tasks

  get "/task_states", to: "tasks#states"

  resources :workspaces do
    resources :projects
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
