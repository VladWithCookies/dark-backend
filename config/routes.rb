Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resource :user_token, only: :create
    end
  end
end
