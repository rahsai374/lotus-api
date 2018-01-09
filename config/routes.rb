Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :payments, only: [] do
    member do
      get :process_payment
    end
    collection do
      post :create_approve_url
    end
  end
end
