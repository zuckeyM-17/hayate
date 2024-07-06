# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  title      :string
#  url        :string
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Link < ApplicationRecord
  def self.get_title(url)
    html = OpenURI.open_uri(url).read
    doc = Nokogiri::HTML(html)
    doc.css('title').text
  rescue StandardError => _e
    nil
  end

  def read!
    update!(read_at: Time.zone.now)
  end

  def read?
    read_at.present?
  end
end
