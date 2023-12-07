class Question < ApplicationRecord

    validates :question_text, presence: true

    has_one :answer
end
