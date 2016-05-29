class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(users_params)
    if @user.valid?
      @user.generate_verification_code
      @user.send_verification_code
    end
    respond_to do |format|
      format.js
    end
  end

  def verify
    @user = User.find_by(mobile_number: params[:hidden_mobile_number])
    if @user.verify(params[:verification_code])
      puts 'verified'
    end

    respond_to do |format|
      format.js
    end
  end

  private
  def users_params
    params.require(:user).permit(:mobile_number)
  end
end