module ApplicationHelper
  def mailing_list_url
    'https://groups.google.com/forum/#!forum/nwrug-members'
  end

  def render_markdown(markdown)
    GitHub::Markup::Markdown.new.render(markdown).html_safe
  end
end
