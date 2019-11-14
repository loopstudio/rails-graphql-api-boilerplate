# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  publisher_id :integer
#

FactoryBot.define do
  factory :book do
    user { nil }
    title { Faker::Book.title }
  end
end
