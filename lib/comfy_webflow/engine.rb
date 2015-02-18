module ComfyWebflow
  class Engine < ::Rails::Engine
    # The block you pass to this method will run for every request in
    # development mode, but only once in production.
    config.to_prepare do
      Comfy::Cms::Layout.send :include, ComfyWebflow::ComfyExtensions::Layout
      Comfy::Cms::Snippet.send :include, ComfyWebflow::ComfyExtensions::Snippet
      Comfy::Cms::File.send :include, ComfyWebflow::ComfyExtensions::File
    end
  end
end
