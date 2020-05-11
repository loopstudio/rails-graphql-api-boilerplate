# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  country_id      :integer
#  password_digest :string
#  email           :string
#

class User < ApplicationRecord
  has_secure_password
  after_update :notify_subscriber_of_addition

  validates :email, presence: true, uniqueness: true

  private

  def notify_subscriber_of_addition
    RailsApiBoilerplateSchema.subscriptions.trigger('user_updated', {}, self)
  end
end
