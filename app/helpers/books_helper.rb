# frozen_string_literal: true

module BooksHelper
  def book_category(category)
    color_map = {
      'engineering' => 'bg-green-100',
      'management' => 'bg-blue-100',
      'english' => 'bg-yellow-100',
      'other' => 'bg-gray-100'
    }

    content_tag(:span, class: "rounded-md text-xs text-gray-900 #{color_map[category]} py-0.5 px-1") do
      category
    end
  end
end
