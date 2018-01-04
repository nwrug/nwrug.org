require 'redcarpet/render_strip'

module ApplicationHelper
  def mailing_list_url
    'https://groups.google.com/forum/#!forum/nwrug-members'
  end

  def google_maps_embed_url(location)
    map_query = [location.name, location.street_address, location.city].join(', ')
    "https://www.google.com/maps/embed/v1/place?q=#{map_query}&key=AIzaSyByIp6AzlpPjVjisNnNNKHMwn_i8XwCWdc"
  end

  def render_markdown(markdown)
    markdown_renderer.render(nil, markdown).html_safe
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
