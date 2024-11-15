# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :integer           not null, primary key
#  user_id     :integer           not null
#  title       :string           not null
#  description :text
#  priority    :integer          default("inbox"), not null
#  category    :integer          default("other"), not null
#  due_at      :datetime
#  done_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :user

  enum :priority, { inbox: 0, today: 10 }
  enum :category, { other: 0, work: 10, skill: 20, personal: 30, housework: 40 }

  validates :title, presence: true

  scope :inbox, -> { where(priority: :inbox) }
  scope :today, -> { where(priority: :today) }

  scope :other, -> { where(category: :other) }
  scope :work, -> { where(category: :work) }
  scope :skill, -> { where(category: :skill) }
  scope :personal, -> { where(category: :personal) }
  scope :housework, -> { where(category: :housework) }

  scope :todo, -> { where(done_at: nil) }
  scope :done, -> { where.not(done_at: nil) }

  def done?
    done_at.present?
  end

  def done!
    update(done_at: Time.zone.now)
  end
end
