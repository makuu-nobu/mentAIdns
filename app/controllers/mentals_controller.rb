class MentalsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :result]

    def index
    end

    def new
        setQuestion
    end

    def create
        @conductor = Conductor.new(question_params)
        if @conductor.valid?
            @conductor.save
            @question = SampleQuestion.random_question.text
            render json:{ question: @question}
            puts "Conductor saved successfully!"
        else
            setQuestion
            puts @conductor.errors.full_messages
            redirect_to root_path, flash: {success: '処理に失敗しました。トップページに戻ります'}
        end
    end

    def show
        api_key = ENV["OPEN_API_KEY"]
        user_id = params[:id]
        results = Editor.editText(user_id)
        #question = 'テストメッセージです。レスポンスには「通信完了しました」と記述してください'

        response = Openai.chat_gpt(api_key, results)
        @result = response['choices'][0]['message']['content']
        result_save(@result)
    end

    def result
        @results = Result.includes(:user).order("created_at DESC")
    end

    def user
        #これが履歴表示、これまでの記録で飛ぶページ
        user_id = params[:id]
        @results = Result.where(user_id: user_id)
    end

    private
    def setQuestion
        @conductor = Conductor.new
        @conductor.question_text = SampleQuestion.random_question.text
        @choices = []
        setChoices(@choices)        
    end

    def setChoices(choices)
        choices.push("当てはまる")
        choices.push("少し当てはまる")
        choices.push("あまり当てはまらない")
        choices.push("当てはまらない")
    end

    def question_params
        params.permit(:question_text,:result_answer, :choice_2, :choice_3, :choice_4, :answer_time).merge(user_id: current_user.id)
    end

    def result_save(result)
        @text = Result.new(result_text: result, user_id: current_user.id)
        if @text.valid?
            @text.save
        else
            puts "保存に失敗しました"
        end
    end
end
