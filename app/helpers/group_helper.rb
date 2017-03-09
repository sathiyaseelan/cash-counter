module GroupHelper

  def is_admin?(group_id:)
    Member.find_by(user_id: current_user.id, group_id: group_id, role: :admin) != nil
  end
end
