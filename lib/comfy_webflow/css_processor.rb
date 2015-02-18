class ComfyWebflow::CssProcessor
  extend ComfyWebflow::Tools

  # Change urls to assets in css with cms file- or asset tags.
  # http://stackoverflow.com/questions/19518086/what-regex-to-match-all-occurrences-of-css-urls
  def self.assets_to_tags(content)
    content.scan(/(url\((['"]?)(.*?)\2\))/).each do |attribute, s, url|
      if relative?(url) && file?(url)
        if css_file?(url) || js_file?(url)
          content.gsub! attribute, "url('{{ cms:asset:#{filename(url)} }}')"
        else
          content.gsub! attribute, "url('{{ cms:file:#{filename(url)} }}')"
        end
      end
    end
    content
  end
end
