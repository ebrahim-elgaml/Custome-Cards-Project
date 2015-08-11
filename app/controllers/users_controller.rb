class UsersController < ApplicationController
  before_action :authenticate_user!
  def edit
  	@user = User.find(params[:id])
  	unless @user == current_user
  		redirect_to root_path, notice: "No permission"
  	end
  end

  def update
  	if current_user.update(user_params)
  		redirect_to root_path, notice: "Updated successfully"
  	else
  		redirect_to :back, notice: current_user.errors.full_messages.first
  	end
  end

  def edit_password
  	@user = User.find(params[:id])
  	unless @user == current_user
  		redirect_to root_path, notice: "No permission"
  	end
  end


  private

	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :phone_number)
	  end

	  def user_without_passowrd_params
	    params.require(:user).permit(:first_name, :last_name, :phone_number)
	  end

end
