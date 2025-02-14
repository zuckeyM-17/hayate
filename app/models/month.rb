# frozen_string_literal: true

class Month
  include ActiveModel::API

  attr_accessor :year, :month

  validates :year, :month, presence: true

  def initialize(id)
    date = Date.parse("#{id}-01")
    @year = date.year
    @month = date.month
  end

  class << self
    def date_to_id(date)
      "#{date.year}-#{date.month}"
    end
  end

  def id
    "#{year}-#{month}"
  end

  def all_month
    Date.new(year, month, 1).all_month
  end

  def to_s
    "#{year}年#{month}月"
  end

  def next
    date = Date.parse("#{year}-#{month}-01") + 1.month
    self.class.new(self.class.date_to_id(date))
  end

  def prev
    date = Date.parse("#{year}-#{month}-01") - 1.month
    self.class.new(self.class.date_to_id(date))
  end
end
