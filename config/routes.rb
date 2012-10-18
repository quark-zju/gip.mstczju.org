RailsNew::Application.routes.draw do

  scope '/vote' do
    resources :topics do
      member do
        post :vote
        post :unvote
      end
    end

    resources :comments
  end

  devise_for :staffs, :controllers => {sessions: 'sessions'}

  root to: 'topics#index'
end
