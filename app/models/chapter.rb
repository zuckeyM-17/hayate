# frozen_string_literal: true

# == Schema Information
#
# Table name: chapters
#
#  id         :bigint           not null, primary key
#  book_id    :bigint           not null
#  title      :string           not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chapters_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#

class Chapter < ApplicationRecord
  belongs_to :book
  has_one :reading, dependent: :destroy
end
