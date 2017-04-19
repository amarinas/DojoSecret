class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new

  end

  def show

    @user = User.find_by_id(params[:id])
    @secrets = Secret.all

  end


end
