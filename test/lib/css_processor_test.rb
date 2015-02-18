require 'test_helper'

class CssProcessorTest < ActiveSupport::TestCase
  test 'it should include tools' do
    assert ComfyWebflow::CssProcessor.respond_to? :unescape_tags
  end

  test 'it should change asset urls to cms tags' do
    assert_match "background-image: -webkit-linear-gradient(rgba(199, 0, 63, 0), rgba(199, 0, 63, 0.4)), url('{{ cms:file:baz.jpg }}');",
      ComfyWebflow::CssProcessor.assets_to_tags("background-image: -webkit-linear-gradient(rgba(199, 0, 63, 0), rgba(199, 0, 63, 0.4)), url('../foo/bar/baz.jpg');")

    assert_match "src: url('{{ cms:file:foo.eot }}') format('embedded-opentype'), url('{{ cms:file:foo.woff }}') format('woff'), url('{{ cms:file:foo.ttf }}') format('truetype');",
      ComfyWebflow::CssProcessor.assets_to_tags("src: url('../fonts/foo.eot') format('embedded-opentype'), url('../fonts/foo.woff') format('woff'), url('../fonts/foo.ttf') format('truetype');")
  end

  test 'it should not change absolute asset urls to cms tags' do
    assert_match "background-image: url('http://foo.bar/baz.jpg');",
      ComfyWebflow::CssProcessor.assets_to_tags("background-image: url('http://foo.bar/baz.jpg');")
  end
end
