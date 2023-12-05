class Conductor
    include ActiveModel::Model

    attr_accessor :question_text, :result_answer, :choice_2, :choice_3, :choice_4, :answer_time, :user_id

    with_options presence: true do
        validates :question_text
        validates :result_answer
        validates :choice_2
        validates :choice_3
        validates :choice_4
        validates :answer_time
        validates :user_id
    end


    def save
        question = Question.create(question_text: question_text)
        puts "Question #{question.id}"
        choice = Choice.create(question_id: question.id, result_answer: result_answer, choice_2: choice_2, choice_3: choice_3, choice_4: choice_4, answer_time: answer_time)
        puts "Choice #{choice.id}"
        Answer.create(user_id: user_id, question_id: question.id, choice_id: choice.id)
        binding.pry
        puts "Answer save"
    end
end