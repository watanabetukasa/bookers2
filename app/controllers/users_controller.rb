class UsersController < ApplicationController


  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end


  def create
    user = User.new(user_params)
    if user.save
      redirect_to users_path
      flash[:create] = 'You have created book successfully.'
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end


end
