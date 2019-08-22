# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string
#  capital    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :country do
    name { Faker::Nation.name }
    capital { Faker::Nation.capital_city }
  end
end
