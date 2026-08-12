require 'test_helper'

class OpenGraphImageTest < ActiveSupport::TestCase
  test 'it generates a default PNG of the correct size' do
    png = OpenGraphImage.new.generate

    assert png.start_with?("\x89PNG".b)

    image = Vips::Image.new_from_buffer(png, '')
    assert_equal 1200, image.width
    assert_equal 630, image.height
  end
end
