class UsersController < ApplicationController

  skip_before_action :authenticate_request!, only: [:create, :login]

  def create
    response = UsersService.new.create_user user_params
    if response.success?
      UserMailer.signup_mail(user: response.entity).deliver_now
      render json: response, status: :created
    else
      render json: response, status: :unprocessable_entity
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  def login
    response = UsersService.new.sign_in_user login_params
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: :unauthorized
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  def show
    response = UsersService.new.find_user user_id: params[:id]
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: :not_found
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end
  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:mobile,:password)
  end

  def login_params
    convert_keys_to_symbols params.require(:user).permit(:email, :password).to_h
  end
end
