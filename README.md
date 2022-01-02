# Favicon Generator

## Getting Started

To run this script you have to install [ImageMagick](https://imagemagick.org/) or make sure that it is already installed.

This bash script takes an image as a parameter, and uses ImageMagick to convert it to several other formats used on modern websites. The dimensions of your picture should be at least 512x512 pixels.

```
./favicon.sh image.png
```

You can also create a list with all tags of the created favicons with the flag `-x` as the second argument. A file favicons.txt will be created for this. You can simply insert the content of this file into the `<head>` of your html page.

```
./favicon.sh image.png -x
```

## The following copies are generated

- favicon.ico _(16x16 32x32 64x64 96x96)_
- favicon-16x16.png _(16x16)_
- favicon-32x32.png _(32x32)_
- favicon-64x64.png _(64x64)_
- favicon-96x96.png _(96x96)_
- favicon-128x128.png _(128x128)_
- favicon-256x256.png _(256x256)_
- favicon-512x512.png _(512x512)_
- apple-touch-icon-152x152.png _(152x152)_
- apple-touch-icon-167x167.png _(167x167)_
- apple-touch-icon-180x180.png _(180x180)_

## License

Licensed under the [GPL-3.0 License ](/LICENSE) license by Mateus V. Farias.
