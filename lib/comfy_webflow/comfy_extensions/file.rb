module ComfyWebflow::ComfyExtensions::File
  extend ActiveSupport::Concern

  included do
    alias_method_chain :stream, :webflow
  end

  # Returns the file stream with Webflow specific parsing:
  #   * urls to assets in stylesheets are replaced with cms file or asset tags
  def stream_with_webflow
    ComfyWebflow::CssProcessor.assets_to_tags stream_without_webflow
  end
end
