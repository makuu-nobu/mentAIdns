class MentalsController < ApplicationController
    before_action :authenticate_user!
    def index
    end
    def new
        @form = Conductor.new
        @form.question_text = SampleQuestion.random_question.text
        @choices = []
        setChoices(@choices)
    end
    def create
        @conductor = Conductoer.new(question_params)
        if @conductor.valid?
            @conductor.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
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

    def question_params
        params.permit(:question_text, :result_answer, :choice_2, :choice_3, :choice_4).merge( answer_time: 10)        
    end
end
