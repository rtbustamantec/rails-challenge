class UsersController < ApplicationController
  before_action :not_authorized, only: [:show, :edit, :update]
  before_action :not_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(users_params)
    if @user.valid?
      @user.generate_verification_code
      @user.send_verification_code
      log_out if logged_in?
    end
    respond_to do |format|
      format.js
    end
  end

  def verify
    @user = User.find_by(mobile_number: params[:hidden_mobile_number])
    if @user.verify(params[:verification_code])
      UserSession.create(@user, true)
    end
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update_attributes(edit_users_params)
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private
    def users_params
      params.require(:user).permit(:mobile_number)
    end

    def edit_users_params
      params.require(:user).permit(:name, :email, :photo)
    end

    def not_authorized
      unless logged_in?
        redirect_to root_path
      end
    end

    def not_authenticated
      redirect_to profile_path if logged_in?
    end
end