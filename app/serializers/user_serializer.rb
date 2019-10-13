class MessageSerializer < ApplicationSerializer
  attributes :email

  has_many :messages
end
