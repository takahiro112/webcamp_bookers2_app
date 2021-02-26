class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if  @user.update(user_params)
    redirect_to user_path(@user.id), notice:"successfully update"
    else
    render "edit"
    end

  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end


 private

  def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def ensure_current_user
        @user = User.find(params[:id])
    if @user.id != current_user.id
        redirect_to user_path(current_user.id)
    end
  end


end
