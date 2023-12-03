class MentalsController < ApplicationController
    def index
    end
    def new
        @form = Form.new
        @form.question_text = "ここに問題文を表示しよう"
        @choices = ["Option 1", "Option 2", "Option 3", "Option 4"]
    end
    def create
        
    end
end
