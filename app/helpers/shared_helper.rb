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
end
