class MentalsController < ApplicationController
    before_action :authenticate_user!
    def index
    end
    def new
        @form = Question.new
        @form.question_text = SampleQuestion.random_question.text
        @choices = []
        setChoices(@choices)
    end
    def create
        binding.pry
        @question = answer.new()
    end

    private
    def setChoices(choices)
        choices.push("当てはまる")
        choices.push("少し当てはまる")
        choices.push("あまり当てはまらない")
        choices.push("当てはまらない")
    end
    def question_params
        binding.pry
    end
end
