class Conductor
    include ActiveModel::Model

    attr_accessor :question_text, :result_answer, :choice_2, :choice_3, :choice_4, :answer_time, :question_id, :user_id


    def save
        question = Question.create(question_text: question_text)
        choice = Choice.create(question_id: question.id, result_answer: result_answer, choice_2: choice_2, choice_3: choice_3, choice_4: choice_4, answer_time: answer_time)
        Answer.create(user_id: user_id, question_id: question.id, choice_id: choice.id)
    end
end