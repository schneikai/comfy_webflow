# ComfyWebflow

Extensions for Comfy that make it more easy to import pages created with Webflow.

This project rocks and uses MIT-LICENSE.


## Assets

If you have a HTML file created with Webflow and you use it as a layout
ComfyWebflow will convert URLs to assets to Comfy asset tags so the correct file
is rendered. Make sure you upload this file to the Comfy files library.

For example this
```html
  <link rel="stylesheet" type="text/css" href="/foo/bar/baz.css">
```

becomes
```html
  <link rel="stylesheet" type="text/css" href="{{ cms:asset:baz.css }}">
```

Only relative URLs are converted. Absolute URLs are left unchanged so you can
still include your external files like
```html
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
```

### Assets inside Webflow CSS

If your Webdlow CSS includes files ComfyWebflow will convert this URLs to
Comfy file tags.

For Example this
```css
  background-image: -webkit-linear-gradient(rgba(199, 0, 63, 0), rgba(199, 0, 63, 0.4)), url('../foo/bar/baz.jpg');
```

becomes
```css
  background-image: -webkit-linear-gradient(rgba(199, 0, 63, 0), rgba(199, 0, 63, 0.4)), url('{{ cms:file:baz.jpg }}');
```

## Links

If your Webflow HTML contains relative links to HTML documents the *html*
extension is removed and just the path is used. If you setup your Webflow
document structure to match your Rails routes all links will work when
you import the Webflow HTML to Comfy.

For example you have that link in your Webflow HTML
```html
  <a href="/photos.html">Show me photos</a>
```
it would be converted to
```html
  <a href="/photos">Show me photos</a>
```

## Setup Comfy tags in Webflow

You can add special data attributes to html tags in Webflow that would convert
the HTML tag to a Comfy PageField tag when you import the Webflow HTML to Comfy.

For Example
```html
  <h1 data-cms-tag="cms:page:headline:text">Welcome!</h1>"
  => <h1>{{ cms:page:headline:text }}</h1>"
```

If you need the cms tag to be inserted in for example a html tag attribute
you can use the data-cms-tag-target attribute like this:
```html
  <a href="index.html" data-cms-tag="cms:helper:root_path" data-cms-tag-target="href">Home</a>"
  => <a href="{{ cms:helper:root_path }}">Home</a>"
```

If you want to replace the complete node with the tag use +self+ as target like this:
```html
  <div data-cms-tag="cms:partial:main-menu" data-cms-tag-target="self">...</div>"
  => {{ cms:partial:main-menu }}
```

## TODO
* import assets by uploading the webflow export zip
