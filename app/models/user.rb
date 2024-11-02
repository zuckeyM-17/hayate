# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :daily_task_items, dependent: :destroy
  has_many :daily_task_sets, through: :daily_task_items
  has_many :word_searches, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :favorite_links, dependent: :destroy
end
