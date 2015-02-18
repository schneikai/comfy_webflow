class ComfyWebflow::HtmlProcessor
  extend ComfyWebflow::Tools

  # Change asset urls in +src+ or +href+ attributes to cms asset- or file tags.
  def self.assets_to_tags(content)
    frag = string_to_html_fragment(content)

    %w(src href).each do |attribute|
      # Using *css* now because of this bug https://github.com/sparklemotion/nokogiri/issues/572.
      # doc.xpath("//*[@#{attribute}]").each do |tag|
      frag.css("[@#{attribute}]").each do |tag|
        url = tag[attribute]
        if relative?(url) && file?(url) && !html_file?(url)
          if css_file?(url) || js_file?(url)
            tag[attribute] = "{{ cms:asset:#{filename(url)} }}"
          else
            tag[attribute] = "{{ cms:file:#{filename(url)} }}"
          end
        end
      end
    end

    unescape_tags frag.to_html
  end

  # Replace links to html documents with just paths.
  def self.link(content)
    frag = string_to_html_fragment(content)

    # Using *css* now because of this bug https://github.com/sparklemotion/nokogiri/issues/572.
    # frag.xpath("//*[@href]").each do |tag|
    frag.css("[@href]").each do |tag|
      url = tag['href']
      if relative?(url) && file?(url) && html_file?(url)
        url.gsub! '.html', ''
        url = '/' if url == 'index'
        tag['href'] = url
      end
    end

    unescape_tags frag.to_html
  end

  # Parse the cms-tag data attribute. By default the html tag content is
  # replaced by a cms tag from data-cms-tag attribute like this:
  #
  #   <h1 data-cms-tag="cms:page:headline:text">Welcome!</h1>"
  #   => <h1>{{ cms:page:headline:text }}</h1>"
  #
  # If you need the cms tag to be inserted in for example a html tag attribute
  # you can use the data-cms-tag-target attribute like this:
  #
  #   <a href="index.html" data-cms-tag="cms:helper:root_path" data-cms-tag-target="href">Home</a>"
  #   => <a href="{{ cms:helper:root_path }}">Home</a>"
  #
  # If you want to replace the complete node with the tag use +self+ as target like this:
  #
  #   <div data-cms-tag="cms:partial:main-menu" data-cms-tag-target="self">...</div>"
  #   => {{ cms:partial:main-menu }}
  #
  def self.attributes_to_tags(content)
    frag = string_to_html_fragment(content)
    attribute = 'data-cms-tag'

    # Using *css* now because of this bug https://github.com/sparklemotion/nokogiri/issues/572.
    # frag.xpath("//*[@#{attribute}]").each do |tag|
    frag.css("[@#{attribute}]").each do |tag|
      cms_tag = "{{ #{tag[attribute]} }}"
      if target = tag['data-cms-tag-target']
        if target == 'self'
          tag.replace cms_tag
        else
          tag[target] = cms_tag
        end
        tag.delete 'data-cms-tag-target'
      else
        tag.content = cms_tag
      end
      tag.delete attribute
    end

    unescape_tags frag.to_html
  end

  protected

  def self.string_to_html_fragment(content)
    Nokogiri::HTML.fragment(content)
  end
end
