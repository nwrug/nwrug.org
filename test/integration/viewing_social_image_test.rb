require 'test_helper'

class ViewingSocialImageTest < ActionDispatch::IntegrationTest
  test 'social image endpoint serves a PNG' do
    event = events(:next_event)

    visit event_open_graph_image_path(event, format: :png)

    assert_equal 200, page.status_code
    assert_equal 'image/png', page.response_headers['Content-Type']
  end

  test 'non-event pages use the default card' do
    visit root_path

    assert page.has_css?('meta[property="og:image"][content$="/images/og-image.png"]', visible: false)
    assert page.has_css?('meta[name="twitter:card"][content="summary_large_image"]', visible: false)
  end
end
