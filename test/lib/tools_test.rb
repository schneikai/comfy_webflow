require 'test_helper'

class ToolsTest < ActiveSupport::TestCase
  setup do
    @tools = Object.new
    @tools.extend ComfyWebflow::Tools
  end

  test "it should unescape tags" do
    assert_equal "Foo {{ cms:page:headline:string }} bar baz.", @tools.unescape_tags("Foo %7B%7Bcms:page:headline:string%7D%7D bar baz.")
  end

  test 'it should identify files' do
    assert @tools.file?("foo/bar/baz.jpg")
    assert_not @tools.file?("foo/bar/baz")
  end

  test 'it should identify css files' do
    assert @tools.css_file?("foo/bar/baz.css")
    assert_not @tools.css_file?("foo/bar/baz.jpg")
  end

  test 'it should identify js files' do
    assert @tools.js_file?("foo/bar/baz.js")
    assert_not @tools.js_file?("foo/bar/baz.jpg")
  end

  test 'it should identify html files' do
    assert @tools.html_file?("foo/bar/baz.html")
    assert @tools.html_file?("foo/bar/baz.htm")
    assert_not @tools.html_file?("foo/bar/baz.jpg")
  end

  test 'it should identify asp files' do
    assert @tools.asp_file?("foo/bar/baz.asp")
    assert_not @tools.asp_file?("foo/bar/baz.jpg")
  end

  test 'it should returns filename from url' do
    assert_equal 'baz.html', @tools.filename("foo/bar/baz.html")
  end

  test 'it should return file extension from url' do
    assert_equal 'html', @tools.file_extension("foo/bar/baz.html")
    assert_nil @tools.file_extension("foo/bar/baz")
  end

  test 'it should identify relative urls' do
    assert @tools.relative?("foo/bar/baz.html")
    assert_not @tools.relative?("http://www.foo.com/bar/baz.html")
  end

  test 'it should identify absolute urls' do
    assert @tools.absolute?("http://www.foo.com/bar/baz.html")
    assert_not @tools.absolute?("foo/bar/baz.html")
  end
end
