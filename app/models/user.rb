# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           default(""), not null
#  first_name      :string           default(""), not null
#  last_name       :string           default(""), not null
#  mobile          :string           default(""), not null
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :string           default("user")
#

class User < ApplicationRecord

  has_secure_password

  has_and_belongs_to_many :groups

  validates :email, uniqueness: true, presence: true
  validates :mobile, uniqueness: true, presence: true

  def administering_groups
    Group.find_by({admin_id: self.id})
  end

end
