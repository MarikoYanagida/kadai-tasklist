class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      flash[:success] = 'ユーザを登録しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end
    #成功時は redirect_to root_url
    # user#indexとuser#showは不要なので削除


private
#strong parameter
def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

end 