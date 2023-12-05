class Choice < ApplicationRecord

    with_options presence: true do
        validates :question_id
        validates :result_answer
        validates :choice_2
        validates :choice_3
        validates :choice_4
        validates :answer_time
    end

    #belongs_to :answer
end
