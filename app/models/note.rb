# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Note < ApplicationRecord
  has_one :reading_note, dependent: :destroy
  has_one :reading, through: :reading_note
  has_one :link_note, dependent: :destroy
  has_one :link, through: :link_note
  has_one :task_note, dependent: :destroy
  has_one :task, through: :task_note
  has_one :event_note, dependent: :destroy
  has_one :event, through: :event_note
  belongs_to :user

  before_save :set_url_href

  scope :today, -> { where(created_at: Time.zone.today.all_day) }

  validates :body, presence: true

  private

  def set_url_href
    url_regex = %r{
      (?<=^|\s)         # 文頭またはスペースの直後（肯定の先読み）
      (https?|ftp)      # スキーム (http, https, ftp)
      ://
      [^\s/$.?#].[^\s]* # ドメイン名とパス
      (?=$|\s)          # 文末またはスペースの直前（肯定の先読み）
    }ix
    self.body = body.gsub(url_regex) do |url|
      "[#{url}](#{url})"
    end
  end
end
