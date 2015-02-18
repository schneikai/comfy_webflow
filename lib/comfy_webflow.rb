require "comfy_webflow/engine"

module ComfyWebflow
  module ComfyExtensions
    autoload :Layout, 'comfy_webflow/comfy_extensions/layout'
    autoload :Snippet, 'comfy_webflow/comfy_extensions/snippet'
    autoload :File, 'comfy_webflow/comfy_extensions/file'
  end

  autoload :Tools, 'comfy_webflow/tools'
  autoload :HtmlProcessor, 'comfy_webflow/html_processor'
  autoload :CssProcessor, 'comfy_webflow/css_processor'
end
