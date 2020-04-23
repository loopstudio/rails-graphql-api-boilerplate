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
  subject(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
