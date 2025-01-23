# frozen_string_literal: true

# == Schema Information
#
# Table name: weekly_reviews
#
#  id                  :bigint           not null, primary key
#  weekly_objective_id :bigint           not null
#  review              :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_weekly_reviews_on_weekly_objective_id  (weekly_objective_id)
#
# Foreign Keys
#
#  fk_rails_...  (weekly_objective_id => weekly_objectives.id)
#
class WeeklyReview < ApplicationRecord
  belongs_to :weekly_objective
  validates :review, presence: true
end
