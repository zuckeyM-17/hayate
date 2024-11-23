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

  def sidebar_link_to(path, icon, text)
    active = 'dark:bg-gray-800 dark:text-gray-50' if current_page?(path)
    tag.li class: "overflow-hidden h-10 flex items-center #{active}" do
      link_to(path, class: 'flex items-center p-2 space-x-3 rounded-md') do
        concat tag.span icon
        concat tag.span " #{text}", class: 'invisible lg:visible'
      end
    end
  end
end
