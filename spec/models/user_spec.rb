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

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
end
