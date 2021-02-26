class BooksController < ApplicationController

 before_action :authenticate_user!
 before_action :baria_user, only: [:edit, :destroy, :update]

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @book_new = Book.new
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
       redirect_to book_path(@book.id), notice:"successfully created"
    else
      @books = Book.all
      @user = current_user
       render "index"
    end

  end

  def update
    @book = Book.find(params[:id])

    if @book.update (book_params)
       redirect_to book_path(@book), notice:"successfully edited"
    else
       render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books", notice:"successfully deleted"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end

  def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def baria_user

    unless Book.find(params[:id]).user.id.to_i == current_user.id
           redirect_to books_path
    end

  end

end
