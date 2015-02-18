module ComfyWebflow::ComfyExtensions::Snippet
  extend ActiveSupport::Concern

  # Returns the layout content with Webflow specific parsing:
  #   * links to assets are replaced with cms file or asset tags
  #   * cms data attributes are parsed and replaced with cms tags (data-cms-tag, ...)
  def content
    content = read_attribute(:content)

    content = ComfyWebflow::HtmlProcessor.assets_to_tags(content)
    content = ComfyWebflow::HtmlProcessor.link(content)
    content = ComfyWebflow::HtmlProcessor.attributes_to_tags(content)

    content
  end
end
