class UsersController < ApplicationController
  before_action :trueuser, only: [:edit]
  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "You have updated user successfully."
    else
    render :edit
    end
  end

  private

  def trueuser
   @user = User.find(params[:id])
   unless @user == current_user
    redirect_to user_path(current_user)
   end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
