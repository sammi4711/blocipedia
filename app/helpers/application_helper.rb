require 'redcarpet'

module ApplicationHelper
  def markdown(text)
    options = {
      hard_wrap: true,
      filter_html: true
    }
    extensions = { 
      autolink: true, 
      no_intraemphasis: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
