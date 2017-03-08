class MembersService < ApplicationService

  # Either user_id or user_email is required
  def create_member(group_id:, user_id: nil, user_email: nil, role: :member)
    @group = Group.find_by(id: group_id)
    if @group.nil?
      return FailureResponse.new(['Can not find the group with given id'])
    else
      if !user_id.nil?
        @user = User.find_by(id: user_id)
        if @user.nil?
          return FailureResponse.new(['Can not find the user with given id'])
        else
          @member = Member.new(group: @group, user: @user, role: role)
          if @member.valid? && @member.save
            return Response.new(@member, success: true)
          else
            return FailureResponse.new(@member.errors.full_messages)
          end
        end
      else
        # To send mail to the new user
        send_join_to_group_mail(user_email, @group)
        return Response.new(['Mail sent to the user'], success: true)
      end
    end
  end

  def destroy_member(group_id: , member_id:)
    @member = Member.find_by(id: member_id)
    if @member.nil? || @member.group_id != group_id.to_i
      return FailureResponse.new(['Can not find member with given ids'])
    elsif @member.admin? && @member.group.admins.size == 1
      return FailureResponse.new(['Can not delete admin (only one available)'])
    elsif @member.destroy
      return Response.new(['Member has been destroyed'], success: true)
    end
  end

end
