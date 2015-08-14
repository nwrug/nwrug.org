require 'redcarpet/render_strip'

module ApplicationHelper
  def mailing_list_url
    'https://groups.google.com/forum/#!forum/nwrug-members'
  end

  def render_markdown(markdown)
    markdown_renderer.render(markdown).html_safe
  end

  def render_plaintext(markdown)
    plaintext_renderer.render(markdown)
  end

  def default_page_title
    'North West Ruby User Group, Manchester, UK'
  end

  def markdown_renderer
    GitHub::Markup::Markdown.new
  end

  def plaintext_renderer
    Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
  end
end
