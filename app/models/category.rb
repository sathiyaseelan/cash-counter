# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  name             :string
#  belongs_to_group :boolean
#  group_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Category < ApplicationRecord

  scope :common_categories, ->() { where(belongs_to_group: false) }

  before_save do
    if self.group_id.nil?
      self.belongs_to_group = false
    else
      self.belongs_to_group = true
    end
  end
  
end
