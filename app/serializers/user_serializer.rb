class UserSerializer < ApplicationSerializer
  attributes :email, :first_name, :last_name

  has_many :messages
end
