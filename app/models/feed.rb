# frozen_string_literal: true

class Feed
  attr_reader :title, :url

  def initialize(title: nil, url: nil)
    @title = title
    @url = url
  end
end
