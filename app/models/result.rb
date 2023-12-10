class Result < ApplicationRecord
    validates :result_text, presence: true
    validates :user_id, presence: true

    belongs_to :user
end
