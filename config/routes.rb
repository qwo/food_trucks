FoodTrucks::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :admin do
    resources :time_slots
    resources :vendors do
      resources :time_slots
      resources :trucks
    end
    resources :locations do
      resources :time_slots
    end
    resources :trucks
  end

  namespace :api do
    get "calendar/locations/:location_id", to: "calendar#locations"
    get "calendar/time_slots", to: "calendar#time_slots"

    resources :time_slots, only: [ :index ]
    resources :feedbacks, only: [ :create ]
    resources :locations, only: [ :index, :show ] do
      collection do
        get :search
      end

      resources :time_slots, only: [ :index, :show ] do
        collection do
          get :search
        end
      end
    end

    resources :vendors, only: [ :index, :show ] do
      collection do
        get :search
      end
    end
  end

  root to: "admin/dashboard#index"
end
