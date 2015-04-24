require 'test_helper'

class HtmlProcessorTest < ActiveSupport::TestCase
  test 'it should include tools' do
    assert ComfyWebflow::HtmlProcessor.respond_to? :unescape_tags
  end

  test 'it should change asset urls to cms tags' do
    assert_match '<link rel="stylesheet" type="text/css" href="{{ cms:asset:baz.css }}">',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<link rel="stylesheet" type="text/css" href="/foo/bar/baz.css">')

    assert_match '<script type="text/javascript" src="{{ cms:asset:baz.js }}"></script>',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<script type="text/javascript" src="/foo/bar/baz.js"></script>')

    assert_match '<img src="{{ cms:file:baz.jpg }}">',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<img src="/foo/bar/baz.jpg">')
  end

  test 'it should not change absolute asset urls to cms tags' do
    assert_match '<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js">',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js">')
  end

  test 'it should not change asset urls for html or asp pages' do
    assert_match '<a href="/foo/bar/baz.html">',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<a href="/foo/bar/baz.html">')

    assert_match '<a href="/foo/bar/baz.asp">',
      ComfyWebflow::HtmlProcessor.assets_to_tags('<a href="/foo/bar/baz.asp">')
  end


end
