class ChatSerializer < ApplicationSerializer
  attributes :name, :users

  attributes :users do |object|
    object.users.map do |user|
      user.serializable_hash.transform_keys! do |key|
        key.camelize(:lower)
      end
    end
  end

  has_many :messages
end
