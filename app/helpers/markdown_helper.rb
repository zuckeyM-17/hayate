# frozen_string_literal: true

module MarkdownHelper
  def markdown(md_text)
    doc = Kramdown::Document.new(md_text, input: 'GFM')
    CustomHtmlConverter.convert(doc.root).first
  end

  class CustomHtmlConverter < Kramdown::Converter::Html
    def convert_a(elm, indent)
      elm.attr['class'] = 'text-blue-500 underline'
      elm.attr['target'] = '_blank'
      super
    end

    def convert_hr(elm, indent)
      elm.attr['class'] = 'my-2'
      super
    end

    def convert_header(elm, indent)
      case elm.options[:level]
      when 1
        elm.attr['class'] = 'text-2xl font-bold underline'
      when 2
        elm.attr['class'] = 'text-xl font-semibold'
      when 3
        elm.attr['class'] = 'text-lg font-medium'
      end
      super
    end

    def convert_ul(elm, indent)
      pl = 'pl-4' if indent != 0 && indent.even?
      elm.attr['class'] = "list-disc list-inside #{pl} [&_ul]:list-[revert]"
      super
    end

    def convert_ol(elm, indent)
      pl = 'pl-4' if indent != 0 && indent.even?
      elm.attr['class'] = "list-decimal list-inside #{pl}"
      super
    end
  end
end
