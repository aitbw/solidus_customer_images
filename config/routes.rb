# frozen_string_literal: true

Spree::Core::Engine.routes.append do
  resources :products, only: [] do
    resources :customer_images, only: [:new, :create]
  end

  namespace :admin do
    resources :customer_images do
      member do
        patch :approve
        patch :reject
      end
    end
  end
end
