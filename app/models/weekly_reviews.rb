# frozen_string_literal: true

class WeeklyReview < ApplicationRecord
  belongs_to :weekly_objective
  validates :review, presence: true
end
