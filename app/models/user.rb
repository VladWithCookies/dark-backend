class User < ApplicationRecord
  has_secure_password

  has_many :messages

  has_and_belongs_to_many :chats
end
