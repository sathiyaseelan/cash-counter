class MembersController < ApplicationController
  before_action :create_member_params, only: [:create]
  before_action :validate_create_member_params, only: [:create]

  def create
    response = MembersService.new.create_member(group_id: params[:group_id], user_id: params[:user_id], user_email: params[:user_email], role: params[:role])
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: :not_found
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  def destroy
    response = MembersService.new.destroy_member(group_id: params[:group_id], member_id: params[:id])
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: :unprocessable_entity
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  private
  def create_member_params
    params.permit(:user_id, :user_email, :role)
  end

  def validate_create_member_params
    if params[:group_id].nil? || (params[:user_id].nil? && params[:user_email].nil?)
      render json: FailureResponse.new(['group_id and user_id / user_email is missing in request']), status: :bad_request
    end
  end
end
