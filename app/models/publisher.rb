# == Schema Information
#
# Table name: publishers
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Publisher < ApplicationRecord
  belongs_to :country
  has_many :books, dependent: :destroy
  has_many :users, through: :books
end
