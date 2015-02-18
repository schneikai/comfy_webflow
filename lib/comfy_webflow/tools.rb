require 'nokogiri'

module ComfyWebflow::Tools
  # Nokogiri is escaping curly braces from our cms tags. Unescape them.
  def unescape_tags(content)
    content.gsub(/%7B%7B(%20)*(.+?)(%20)*%7D%7D/, '{{ \2 }}')
  end

  # Returns +true+ if the given url points to a file. Otherwise +false+.
  #
  #   file?("foo/bar/baz.jpg")
  #   => true
  #
  #   file?("foo/bar/baz")
  #   => false
  #
  def file?(url)
    !!file_extension(url)
  end

  def css_file?(url)
    file_extension(url) == 'css'
  end

  def js_file?(url)
    file_extension(url) == 'js'
  end

  def html_file?(url)
    file_extension(url) == 'html' || file_extension(url) == 'htm'
  end

  # Returns just the file name part from the given url. Returns +nil+ if no filename present.
  def filename(url)
    File.basename(URI.parse(url).path).presence
  rescue
    nil
  end

  # Returns just the file extension from the given url. Returns +nil+ if no extension present.
  def file_extension(url)
    File.extname(filename(url)).delete('.').presence
  rescue
    nil
  end

  # Returns +true+ if the given url is relative. Otherwise +false+.
  def relative?(url)
    !absolute?(url)
  end

  # Returns +true+ if the given url is absolute. Otherwise +false+.
  def absolute?(url)
    url =~ /^https?:\/\//i
  end

end
