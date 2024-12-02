# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_links
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  link_id     :bigint           not null
#  archived_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_favorite_links_on_link_id  (link_id)
#  index_favorite_links_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (link_id => links.id)
#  fk_rails_...  (user_id => users.id)
#

class FavoriteLink < ApplicationRecord
  belongs_to :user
end
