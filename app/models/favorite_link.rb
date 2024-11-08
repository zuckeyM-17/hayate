# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_links
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  link_id     :integer          not null
#  archived_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_favorite_links_on_link_id  (link_id)
#  index_favorite_links_on_user_id  (user_id)
#

class FavoriteLink < ApplicationRecord
  belongs_to :user
end
