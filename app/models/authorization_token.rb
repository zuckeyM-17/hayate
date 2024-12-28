# frozen_string_literal: true

# == Schema Information
#
# Table name: authorization_tokens
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string           not null
#  token      :string           not null
#  expires_at :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authorization_tokens_on_token    (token) UNIQUE
#  index_authorization_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class AuthorizationToken < ApplicationRecord
  belongs_to :user
end
