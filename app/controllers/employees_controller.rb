class EmployeesController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.where(is_employee: true)
  end

  def show
  	@user = User.find(params[:id])
  end

  def show_me
  	if current_user.is_employee
      redirect_to employee_path(current_user)
    else
      redirect_to client_path(current_user)
    end
  end
  
end
