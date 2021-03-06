class GroupsController < ApplicationController

  def new
  end

  def create
    response = GroupsService.new.create_group group_params.merge({user: current_user})
    if response.success?
      render json: response, status: :created
    else
      render json: response, status: :unprocessable_entity
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  def show
    response = GroupsService.new(current_user).find_group params[:id]
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: :not_found
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  def destroy
    response = GroupsService.new(current_user).delete_group params[:id]
    if response.success?
      render json: response, status: :ok
    else
      render json: response, status: response.error_code
    end
    rescue Exception => e
      render json: ErrorResponse.new(e.message), status: :internal_server_error
  end

  private

  def group_params
    convert_keys_to_symbols params.require(:group).permit(:name,:description).to_h
  end


end
