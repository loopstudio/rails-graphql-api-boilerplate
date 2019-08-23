# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#

class User < ApplicationRecord
  belongs_to :country
  has_many :books, dependent: :destroy
  has_many :publishers, through: :books

  after_update :notify_subscriber_of_addition

  private

  def notify_subscriber_of_addition
    RailsApiBoilerplateSchema.subscriptions.trigger('user_updated', {}, self)
  end
end
