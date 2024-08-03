# ED Mahjong

An open, ad free, mahjong game, written in flutter.

## Build notes

The project only contains svg versions of the tilesets. They need to be
converted PNGs to use. Run "dart run scripts/convert_tileset.dart" to generate
them. (Requires inkscape)

You can additionally compact the generated files using the
"optimize_tileset.sh" script. (Requires optipng and zopflipng)
