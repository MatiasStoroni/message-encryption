class Message < ApplicationRecord

    validates :body, presence: true

    validates :key, presence: true
    validates :key, length: { in: 1..9 }
end
