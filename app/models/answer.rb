class Answer < ApplicationRecord
    
    with_options presence: true do
        validates :user_id
        validates :question_id
        validates :choice_id
    end

    belongs_to :user
    belongs_to :question
    belongs_to :choice

    def self.limitQuestions
        Answer.order(update_at: :desc).limit(5)   
    end
end
