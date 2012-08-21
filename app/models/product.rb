# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  value      :integer
#  time       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cost       :integer
#  xp         :integer
#

class Product < ActiveRecord::Base
  attr_accessible :name, :time, :value, :cost, :xp
end