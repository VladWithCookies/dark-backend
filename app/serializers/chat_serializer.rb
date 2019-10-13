class ChatSerializer < ApplicationSerializer
  attributes :name

  has_many :messages
end
