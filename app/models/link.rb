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
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    doc.css('title').text
  rescue StandardError => _e
    nil
  end
end
