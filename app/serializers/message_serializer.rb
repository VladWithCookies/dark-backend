class MessageSerializer < ApplicationSerializer
  attributes :text

  belongs_to :chat
  belongs_to :user
end
