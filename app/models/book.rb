# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :uuid             not null, primary key
#  title      :string           not null
#  category   :integer          default("other"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_books_on_title  (title) UNIQUE
#
class Book < ApplicationRecord
  has_many :chapters, dependent: :destroy

  enum category: { engineering: 10, management: 20, english: 30, other: 0 }

  def start!
    Reading.create!(chapter: chapters.min_by(&:number))
  end
end
