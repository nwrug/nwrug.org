require 'test_helper'
require 'tmpdir'
require 'sprockets/manifest'

class AssetManifestTest < ActiveSupport::TestCase
  PREVIOUS_MANIFEST_NAME =
    '.sprockets-manifest-abcdefabcdefabcdefabcdefabcdefab.json'.freeze
  PREVIOUS_STYLESHEET = "application-#{'1' * 64}.css".freeze
  CURRENT_STYLESHEET = "application-#{'2' * 64}.css".freeze

  test 'it resolves the current build’s stylesheet when a previous build’s manifest sits alongside it' do
    Dir.mktmpdir do |assets_directory|
      write_manifest assets_directory, pinned_manifest_filename, CURRENT_STYLESHEET
      write_manifest assets_directory, PREVIOUS_MANIFEST_NAME, PREVIOUS_STYLESHEET

      assert_equal CURRENT_STYLESHEET,
                   manifest_in(assets_directory).assets['application.css']
    end
  end

  test 'it reads nothing at all from a manifest left behind by a previous release' do
    Dir.mktmpdir do |assets_directory|
      write_manifest assets_directory, PREVIOUS_MANIFEST_NAME, PREVIOUS_STYLESHEET

      assert_nil manifest_in(assets_directory).assets['application.css'],
                 'a manifest left behind by an old release was read, which ' \
                 'means the assets folder is being searched instead of one ' \
                 'known filename being looked for'
    end
  end

  private

  def manifest_in(assets_directory)
    Sprockets::Manifest.new(
      nil, assets_directory, configured_manifest_path_in(assets_directory)
    )
  end

  def configured_manifest_path_in(assets_directory)
    configured_manifest_filename &&
      File.join(assets_directory, configured_manifest_filename)
  end

  def configured_manifest_filename
    configured_path = Rails.application.config.assets.manifest
    configured_path && File.basename(configured_path)
  end

  def pinned_manifest_filename
    configured_manifest_filename ||
      flunk('No manifest filename is configured, so a build has no known name ' \
            'to write to, and this situation cannot be set up')
  end

  def write_manifest(assets_directory, filename, stylesheet)
    File.write File.join(assets_directory, filename),
               JSON.generate('assets' => { 'application.css' => stylesheet },
                             'files' => { stylesheet => { 'logical_path' => 'application.css' } })
  end
end
