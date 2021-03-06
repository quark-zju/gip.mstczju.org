RailsNew::Application.routes.draw do

  get "staffs/preferences"

  scope '/vote' do
    resources :topics do
      member do
        post :register
      end
    end

    resources :comments
  end

  devise_for :staffs, :controllers => {sessions: 'sessions'}

  controller :staffs do
    get :preferences
    post :preferences
    get :profile
    put :profile
    get :notifications
  end

  root to: redirect('/vote/topics')
end
