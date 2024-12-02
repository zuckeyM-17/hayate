# frozen_string_literal: true

# == Schema Information
#
# Table name: feeds
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  title      :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fetched_at :datetime
#
# Indexes
#
#  index_feeds_on_url      (url) UNIQUE
#  index_feeds_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Feed < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true
end
