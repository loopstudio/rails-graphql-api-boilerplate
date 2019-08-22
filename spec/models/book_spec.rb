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

require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
