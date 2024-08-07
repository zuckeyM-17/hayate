# frozen_string_literal: true

module TasksHelper
  def task_priority(priority)
    color_map = {
      'new_added' => 'bg-gray-100',
      'today' => 'bg-blue-100',
      'later' => 'bg-yellow-100'
    }

    content_tag(:span, class: "rounded-md text-xs text-gray-900 #{color_map[priority]} py-0.5 px-1") do
      priority
    end
  end

  def task_category(category)
    color_map = {
      'other' => 'bg-gray-100',
      'work' => 'bg-blue-100',
      'skill' => 'bg-yellow-100',
      'personal' => 'bg-green-100',
      'housework' => 'bg-red-100'
    }

    content_tag(:span, class: "rounded-md text-xs text-gray-900 #{color_map[category]} py-0.5 px-1") do
      category
    end
  end
end
