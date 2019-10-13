class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  validates :text, :user, :chat, presence: true
end
