# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string
#  url        :string
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_links_on_user_id  (user_id)
#

class Link < ApplicationRecord
  belongs_to :user

  def self.get_title(url)
    html = OpenURI.open_uri(url).read
    doc = Nokogiri::HTML(html)
    doc.css('title').text
  rescue StandardError => _e
    nil
  end

  scope :unread, -> { where(read_at: nil) }

  def read!
    update!(read_at: Time.zone.now)
  end

  def read?
    read_at.present?
  end
end
