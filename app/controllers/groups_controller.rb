class GroupsController < ApplicationController
  def new
  end

  def create
    @group = Group.new(group_params)
    if @group.valid? && @group.save
      render json: { success: true, message: 'group is created successfully', group_id: @group.id}, status: 200
    else
      render json: { success: false, message: @group.errors.full_messages }, status: 400
    end
  end

  def add_member
  end

  private

  def group_params
    params.require(:group).permit(:name,:description,:admin_id)
  end

  def member_params
  end
end
