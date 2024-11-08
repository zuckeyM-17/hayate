# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id         :integer          not null, primary key
#  book_id    :integer          not null
#  title      :string           not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chapters_on_book_id  (book_id)
#

class Chapter < ApplicationRecord
  belongs_to :book
  has_one :reading, dependent: :destroy
end
