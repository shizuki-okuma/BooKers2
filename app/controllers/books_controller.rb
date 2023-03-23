class BooksController < ApplicationController
  
  def new
    @book = Book.new
    @user = current_user
  end
  
  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])  
    @books = Book.all
    @user = User.find(@book.user.id)
  end

  def edit
     @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end
  
  def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully update."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to books_path
    end
  end
end
