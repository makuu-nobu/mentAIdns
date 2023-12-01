class Answer < ApplicationRecord
    
    with_options presence: true do
        validates :username
        validates :user_id
        validates :question_id
        validates :choice_id
    end

    belongs_to :user
    belongs_to :question
    has_many :choices
end
