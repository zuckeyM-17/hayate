# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

daily_tasks = [
  ['2024/01/01', false, true, true, true, true, true, true, true],
  ['2024/01/02', true, true, true, true, true, true, true, true],
  ['2024/01/03', true, false, true, true, true, true, true, true],
  ['2024/01/04', true, false, true, true, true, true, false, true],
  ['2024/01/05', true, false, true, true, false, true, false, true],
  ['2024/01/06', true, false, true, true, true, true, false, true],
  ['2024/01/07', true, false, true, true, true, true, true, true],
  ['2024/01/08', true, false, true, true, true, true, true, true],
  ['2024/01/09', true, true, true, true, true, true, true, true],
  ['2024/01/10', true, true, true, true, true, true, true, true],
  ['2024/01/11', true, false, true, true, true, true, true, true],
  ['2024/01/12', true, true, true, true, true, true, false, true],
  ['2024/01/13', true, true, true, true, true, true, true, true],
  ['2024/01/14', true, true, true, true, true, true, true, true],
  ['2024/01/15', true, true, true, true, true, true, true, true],
  ['2024/01/16', true, true, true, true, true, true, false, true],
  ['2024/01/17', true, false, true, true, true, true, true, true],
  ['2024/01/18', true, false, true, true, true, true, true, true],
  ['2024/01/19', true, false, true, true, false, true, false, true],
  ['2024/01/20', true, true, true, true, true, true, false, true],
  ['2024/01/21', true, true, true, true, true, true, true, true],
  ['2024/01/22', true, true, true, true, true, true, true, true],
  ['2024/01/23', true, true, true, true, true, true, false, true],
  ['2024/01/24', true, false, true, true, false, true, false, false],
  ['2024/01/25', true, false, true, true, true, true, true, true],
  ['2024/01/26', true, true, true, true, true, true, true, true],
  ['2024/01/27', true, true, true, true, true, true, false, true],
  ['2024/01/28', true, true, true, true, true, true, false, true]
]

daily_tasks.each do |date|
  daily_task_set = DailyTaskSet.create!(date: date[0])
  DailyTaskItem.enabled.each.with_index do |item, i|
    DailyTask.create!(daily_task_set:, daily_task_item: item, done: date[i])
  end
end
