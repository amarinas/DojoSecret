class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :login, :create]

  def new

  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to "/users/#{ @user.id }"
    else
      flash[:errors] =  @user.errors
      redirect_to '/users/new'

    end

  end


  def destroy
    @secret = Secret.find(params[:id])
    if @secret.user === current_user
      @secret.destroy
      redirect_to "/secrets/new"
  end

  def login
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/users/#{ @user.id}"
    else
      flash[:errors] =  ["wrong credentials"]
      redirect_to '/'

  end
end


  def logout
    session.delete(:user_id)
    redirect_to '/'
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
