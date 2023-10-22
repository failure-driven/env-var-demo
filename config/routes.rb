Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :demos do
    collection do
      get :read_file
    end
  end

  # Defines the root path route ("/")
  root "demos#index"
end
