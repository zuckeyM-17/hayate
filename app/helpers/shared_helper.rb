module SharedHelper
  def sidebar_link_to(path, text)
    classes = "flex items-center p-2 space-x-3 rounded-md"
    active = "dark:bg-gray-800 dark:text-gray-50" if current_page?(path)
    tag.li class: active do
      link_to(path, class: classes) do
        tag.span { text }
      end
    end
  end
end