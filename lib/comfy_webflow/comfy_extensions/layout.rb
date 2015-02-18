module ComfyWebflow::ComfyExtensions::Layout
  extend ActiveSupport::Concern

  included do
    alias_method_chain :merged_content, :webflow
  end

  # Returns the layout content with Webflow specific parsing:
  #   * links to assets are replaced with cms file or asset tags
  #   * cms data attributes are parsed and replaced with cms tags (data-cms-tag, ...)
  def merged_content_with_webflow
    content = merged_content_without_webflow

    content = ComfyWebflow::HtmlProcessor.assets_to_tags(content)
    content = ComfyWebflow::HtmlProcessor.link(content)
    content = ComfyWebflow::HtmlProcessor.attributes_to_tags(content)

    content
  end
end
