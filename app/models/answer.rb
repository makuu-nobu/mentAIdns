class Answer < ApplicationRecord
    
    with_options presence: true do
        validates :user_id
        validates :question_id
        validates :choice_id
    end

    belongs_to :user
    has_many :questions
    has_many :choices
end
