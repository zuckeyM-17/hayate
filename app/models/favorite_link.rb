# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_links
#
#  id          :bigint           not null, primary key
#  link_id     :bigint           not null
#  archived_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_favorite_links_on_link_id  (link_id)
#
# Foreign Keys
#
#  fk_rails_...  (link_id => links.id)
#
class FavoriteLink < ApplicationRecord
end
