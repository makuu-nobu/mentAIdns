class UsersController < ApplicationController
    before_action :move_to_index, only: [:show, :update]

    def show
        #ここが詳細ページ、公開設定と回答の保存ができるようにする
        @user = User.find(params[:id])
        unless @user.id == current_user.id
            redirect_to root_path
        end
        @answers = @user.answers.order("question_id DESC").limit(5)
        if @user.result.present?
            @result = Result.where(user_id: @user.id)
        else
            @result = "まだ診断結果がありません"
        end
    end

    def update
        @user = User.find(params[:id])
    
        if @user.update(user_params)
            flash[:success] = 'ユーザー情報が更新されました。'
            redirect_to "/mentals/#{@user.id}/show"
        else
            flash.now[:error] = '更新に失敗しました。'
            redirect_to "/mentals/#{@user.id}/show"
        end
    end
    
    private
    def move_to_index
        unless user_signed_in?
            redirect_to root_path
        end        
    end

    def user_params
    params.require(:user).permit(:release_option)
    end

end
