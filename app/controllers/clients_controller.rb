class ClientsController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.where(is_employee: false)
  end

  def show
  	@user = User.find(params[:id])
  end
end
