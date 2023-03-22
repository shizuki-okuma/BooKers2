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
      render :new
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
    @user = current_user
  end

  def edit
     @book = Book.find(params[:id])
    
  end
  def update
     @book = Book.find(params[:id])
    if @book.save
      flash[:notice] = "Book was successfully update."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :update
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
  
end
