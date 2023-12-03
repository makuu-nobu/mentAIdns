class MentalsController < ApplicationController
    def index
    end
    def new
        @form = Question.new
        setQuestion(@form)
        @choices = []
        setChoices(@choices)
    end
    def create
        
    end

    private
    def setQuestion(form)
        form.question_text = "サンプル問題です。この中にAIで作成した性格診断のテキストが入ります"        
    end

    def setChoices(choices)
        choices.push("選択肢１")
        choices.push("選択肢2")
        choices.push("選択肢3")
        choices.push("選択肢4")
    end
end
