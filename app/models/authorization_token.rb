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
  EXPIRATION_TIME = 99.years

  belongs_to :user

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true, length: { is: 32 }

  before_validation :generate_token, on: :create
  before_validation :set_expiration, on: :create

  private

  def generate_token
    return if token.present?

    self.token = SecureRandom.hex(16)
  end

  def set_expiration
    return if expires_at.present?

    self.expires_at = EXPIRATION_TIME.from_now
  end
end
