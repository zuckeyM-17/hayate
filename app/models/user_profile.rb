# frozen_string_literal: true

# == Schema Information
#
# Table name: user_profiles
#
#  id           :bigint           not null, primary key
#  display_name :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class UserProfile < ApplicationRecord
  belongs_to :user
end
