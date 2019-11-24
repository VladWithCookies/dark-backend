Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/user_token' => 'user_token#create'

      resources :users, only: %i(index)
      resources :current_users, only: %i(index)

      resources :chats, only: %i(index create update destroy) do
        resources :messages, only: %i(index create update destroy), shallow: true
      end
    end
  end

  mount ActionCable.server => '/cable'
end
