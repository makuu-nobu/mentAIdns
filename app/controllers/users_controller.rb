class UsersController < ApplicationController
    before_action :move_to_index, only: [:show, :update]
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :destroy, only: [:destroy]

    def show
        #ここが詳細ページ、公開設定と回答の保存ができるようにする
        unless @user.id == current_user.id
            redirect_to root_path
        end
        @answers = @user.answers.order("question_id DESC").limit(5)
    end

    def update
        if @user.update(user_params)
            flash[:success] = 'ユーザー情報が更新されました。'
            redirect_to "/mentals/#{@user.id}/show"
        else
            flash.now[:error] = '更新に失敗しました。'
            redirect_to "/mentals/#{@user.id}/show"
        end
    end

    def destroy
        @result = Result.find(@user.result.id)
        @result.destroy
        redirect_to "users/#{@user.id}"
    end
    
    private
    def move_to_index
        unless user_signed_in?
            redirect_to root_path
        end        
    end

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
    params.require(:user).permit(:release_option)
    end

    def user_checker
        unless @user.id == current_user.id
            redirect_to root_path
        end
    end
end
