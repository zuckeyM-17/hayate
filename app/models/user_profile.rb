# frozen_string_literal: true

# == Schema Information
#
# Table name: user_profiles
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  display_name :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class UserProfile < ApplicationRecord
  belongs_to :user
end
