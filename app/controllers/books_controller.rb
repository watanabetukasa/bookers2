class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:create] = 'You have created book successfully.'
      redirect_to "/books/#{@book.id}"
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user == current_user
      @book.destroy
      flash[:destroy] = "Book was successfully destroyed."
      redirect_to books_path
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path
      flash[:update] = 'You have updated book successfully.'
    else
      @user = current_user
      @books = Book.all
      render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
