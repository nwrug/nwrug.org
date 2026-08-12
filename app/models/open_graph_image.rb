# Used to generate Open Graph images for NWRUG with the logo on the left and
# text on the right.
#
# Example usage:
#
#  image = OpenGraphImage.new(
#    title: 'North West Ruby User Group', subheading: "3rd Thursday of the month\n— Manchester, UK"
#  ).generate
#  File.binwrite(Rails.root.join("public/images/og-image.png"), image)
#
class OpenGraphImage
  WIDTH  = 1200
  HEIGHT = 630

  FONT_PATH = Rails.root.join('lib/assets/fonts/Inter.ttf').to_s
  LOGO_PATH = Rails.root.join('app/assets/images/nwrug-logo-social.png').to_s

  BACKGROUND_COLOUR = [26, 45, 53].freeze # brand navy #1A2D35
  TITLE_COLOUR      = [255, 255, 255].freeze # white
  DETAILS_COLOUR    = [228, 169, 31].freeze # brand gold #E4A91F

  TEXT_BLOCK_WIDTH  = 570
  TITLE_FONT_SIZE   = 64
  DETAILS_FONT_SIZE = 34
  TEXT_LEFT = 570
  LOGO_LEFT  = 70

  attr_reader :title, :subheading

  def initialize(title:, subheading:)
    @title = title
    @subheading = subheading
  end

  def generate
    canvas.composite(
      [logo_image, text_block_image], %i[over over],
      x: [LOGO_LEFT, TEXT_LEFT],
      y: [centre_vertically(logo_image), centre_vertically(text_block_image)]
    ).write_to_buffer('.png')
  end

  private

  def canvas
    Vips::Image.black(WIDTH, HEIGHT, bands: 3)
               .linear([1, 1, 1], BACKGROUND_COLOUR)
               .cast(:uchar)
               .copy(interpretation: :srgb)
  end

  # @return [Vips::Image] of the NWRUG logo
  def logo_image
    @logo_image ||= Vips::Image.new_from_file(LOGO_PATH)
  end

  # @return [Vips::Image] of the text block, made up of the title and subheading
  def text_block_image
    @text_block_image ||= title_image.join(subheading_image, :vertical, align: :low, shim: 24, expand: true)
  end

  # @return [Vips::Image] of the title
  def title_image
    image_from_text(title, size: TITLE_FONT_SIZE, width: TEXT_BLOCK_WIDTH, colour: TITLE_COLOUR)
  end

  # @return [Vips::Image] of the subheading
  def subheading_image
    image_from_text(subheading, size: DETAILS_FONT_SIZE, width: TEXT_BLOCK_WIDTH, colour: DETAILS_COLOUR)
  end

  # @return [Vips::Image] of the supplied text
  def image_from_text(text, size:, width:, colour:)
    image = Vips::Image.text(text, fontfile: FONT_PATH, font: "Inter Bold #{size}",
                                  width:, wrap: :word, rgba: true)
    # vips renders black glyphs with an alpha channel; invert to the target colour
    image.linear([-1, -1, -1, 1], colour + [0])
  end


  def centre_vertically(image)
    ((HEIGHT - image.height) / 2.0).round
  end
end
