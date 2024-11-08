# frozen_string_literal: true

# == Schema Information
#
# Table name: user_profiles
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  display_name :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#

class UserProfile < ApplicationRecord
  belongs_to :user
end
