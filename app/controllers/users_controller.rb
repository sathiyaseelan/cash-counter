class UsersController < ApplicationController

  def create
    response = UsersService.new.create_user user_params
    if response.success?
      render json: response, status: :created
    else
      render json: response, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:mobile,:password)
  end
end
