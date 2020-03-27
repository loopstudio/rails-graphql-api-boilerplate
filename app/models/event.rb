# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  field_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
end
