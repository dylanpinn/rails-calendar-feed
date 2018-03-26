# frozen_string_literal: true

Rails.application.routes.draw do
  root 'events#index'
  resources :events do
    collection do
      get 'calendar_feed', defaults: { format: 'ics' }
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
