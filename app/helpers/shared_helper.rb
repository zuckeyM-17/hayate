# frozen_string_literal: true

module SharedHelper
  def full_title(page_title)
    base_title = 'Hayate'
    if page_title.blank?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def sidebar_link_to(path, text)
    classes = 'flex items-center p-2 space-x-3 rounded-md'
    active = 'dark:bg-gray-800 dark:text-gray-50' if current_page?(path)
    tag.li class: active do
      link_to(path, class: classes) do
        tag.span { text }
      end
    end
  end
end
