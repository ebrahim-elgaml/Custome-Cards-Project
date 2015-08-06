class EmployeesController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.where(is_employee: true)
  end

  def show
  	@user = User.find(params[:id])
  end

  def show_me
  	@cards_to_show = params[:cards]
  end
end
