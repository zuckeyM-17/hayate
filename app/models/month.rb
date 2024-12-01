# frozen_string_literal: true

class Month
  include ActiveModel::API

  attr_accessor :year, :month

  validates :year, :month, presence: true

  def initialize(date)
    @year = date.year
    @month = date.month
  end

  def self.future
    today = Time.zone.today
    (0..11).map { |i| new(today + i.months) }
  end

  def days
    first_day = Date.new(year, month, 1)
    (first_day..first_day.end_of_month).to_a
  end

  def to_s
    "#{year}年#{month}月"
  end
end
