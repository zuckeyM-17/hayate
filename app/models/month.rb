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
    def future
      today = Time.zone.today
      (0..11).map do |i|
        new(date_to_id(today + i.months))
      end
    end

    def date_to_id(date)
      "#{date.year}-#{date.month}"
    end
  end

  def id
    "#{year}-#{month}"
  end

  def days
    first_day = Date.new(year, month, 1)
    (first_day..first_day.end_of_month).to_a
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
