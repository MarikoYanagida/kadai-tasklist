class TasklistsController < ApplicationController
  before_action :set_tasklist, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, 
  before_action :correct_user, only: [:destroy]
  
def index
  if logged_in?
    @user = current_user
    @tasklist = current_user.tasklists.build
    @tasklists = current_user.tasklists.order ('created_at DESC').page(params[:page])
  end
  #不要だよね？@tasklists = Tasklist.all.page(params[:page])
end

def show
end

def new
  @tasklist = Tasklist.new
end

def create
  # p "**************"
  # p params
  @tasklist = current_user.tasklists.build(tasklist_params)
  #@tasklist = Tasklist.new(tasklist_params)
  
  if @tasklist.save
    flash[:success] = " Tasklist　が正常に投稿されました"
    redirect_to root_url
  else
    @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
    flash.now[:danger] = 'Tasklist　が投稿に失敗しました'
    render :new
  end
end

def edit
end

def update
  
  if @tasklist.update(tasklist_params)
    flash[:success] = 'Tasklist は正常に更新されました'
    redirect_to @tasklist
    
  else
    flash.now[:danger] = 'Tasklist は更新されませんでした'
    render :edit
  end
end

def destroy
  # before action系のことを書かなくてはいけない
  # くわしくはmicropostsのdestroyのところを参考
  
  @tasklist.destroy
　 flash[:success] = 'Taskは正常に削除されました'
  redirect_to tasklists_url
end

private

def set_tasklist
  @tasklist = Tasklist.find(params[:id])
end

end

# Strong Parameter
def tasklist_params
   params.require(:tasklist).permit(:content, :status)
end


def correct_user
  @tasklist = current_user.tasklists.find_by(id: params[:id])
  unless @tasklist
    redirect_to root_url
  end
end