class SecretsController < ApplicationController
  skip_before_action :require_login, only: [:new]


  def index
    @user = User.find_by_id(params[:id])
    @secrets = Secret.all
  end


  def create
    @users = session[:user_id]
    @secret = Secret.create(secret_params)

    if @secret.valid?
      redirect_to "/users/#{ @users }"
      # render json: @secret
    else
      flash[:errors] = secret.errors
      redirect_to "/users/#{ @users }"
    end
  end

  def destroy
    @secret = Secret.find(params[:id])
    if @secret.user === current_user
      @secret.destroy
      redirect_to "/secrets/new"
    end
  end


  private
    def secret_params
      params.require(:posts).permit(:content).merge(user: current_user)
    end

end
