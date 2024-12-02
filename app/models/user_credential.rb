# == Schema Information
#
# Table name: user_credentials
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  display_name    :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_user_credentials_on_display_name  (display_name) UNIQUE
#  index_user_credentials_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

class UserCredential < ApplicationRecord
  belongs_to :user

  has_secure_password
end
