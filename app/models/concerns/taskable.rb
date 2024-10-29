# frozen_string_literal: true

module Taskable
  extend ActiveSupport::Concern

  included do
    enum :priority, { new_added: 0, today: 10, later: 20 }
    enum :category, { other: 0, work: 10, skill: 20, personal: 30, housework: 40 }

    validates :title, presence: true

    scope :new_added, -> { where(priority: :new_added) }
    scope :today, -> { where(priority: :today) }
    scope :later, -> { where(priority: :later) }

    scope :other, -> { where(category: :other) }
    scope :work, -> { where(category: :work) }
    scope :skill, -> { where(category: :skill) }
    scope :personal, -> { where(category: :personal) }
    scope :housework, -> { where(category: :housework) }
  end
end
