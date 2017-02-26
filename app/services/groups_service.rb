class GroupsService < ApplicationService

  def create_group(name:, description:, user: )
    @group = Group.new({name: name, description: description})
    if @group.valid?
      Group.transaction do
        @group.save!
        raise 'cannot create admin' unless @group.members << Member.new(user: user, role: :admin)
      end
      return Response.new(@group, success: true)
    else
      return FailureResponse.new(@group.errors)
    end
  end

  def find_group(group_id)
    @group = Group.includes(members: [:user]).find_by(id: group_id)
    if @group
      return Response.new(@group, success: true)
    else
      return FailureResponse.new(['Can not find the group with given id'])
    end
  end
end
