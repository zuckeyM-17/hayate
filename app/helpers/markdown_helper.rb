# frozen_string_literal: true

module MarkdownHelper

  def markdown(md_text)
    doc = Kramdown::Document.new(md_text, input: 'GFM')
    CustomHtmlConverter.convert(doc.root).first
  end
  

  class CustomHtmlConverter < Kramdown::Converter::Html
    def convert_a(el, indent)
      el.attr["class"] = "text-blue-500 underline"
      el.attr['target'] = '_blank'
      super
    end

    def convert_hr(el, indent)
      el.attr["class"] = "my-2"
      super
    end

    def convert_header(el, indent)
      case el.options[:level]
      when 1
        el.attr["class"] = "text-2xl font-bold underline"
      when 2
        el.attr["class"] = "text-xl font-semibold"
      when 3
        el.attr["class"] = "text-lg font-medium"
      end
      super
    end

    def convert_ul(el, indent) 
      pl = "pl-4" if indent != 0 && indent % 2 == 0
      el.attr["class"] = "list-disc list-inside #{pl} [&_ul]:list-[revert]"
      super
    end

    def convert_ol(el, indent)
      pl = "pl-4" if indent != 0 && indent % 2 == 0
      el.attr["class"] = "list-decimal list-inside #{pl}"
      super
    end
  end

end