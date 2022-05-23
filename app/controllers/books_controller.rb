class BooksController < ApplicationController
before_action :trueuser, only: [:edit]
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book.id)
     flash[:notice] = "You have updated user successfully."
    else
     @books = Book.all
     render :index
    end
  end


  def index
     @book = Book.new
     @user = current_user
     @books = Book.all
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book)
    flash[:notice] = "You have updated user successfully."
    else
     render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def trueuser
     @book = Book.find(params[:id])
   unless @book.user_id  == current_user.id
    redirect_to  books_path
   end
  end


  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
