# ed_mahjong

An open, ad free, mahjong game, written in flutter.

## Build notes

The project only contains svg versions of the tilesets. They need to be
converted PNGs to use. Run "dart run scripts/convertTileset" to generate
them.

You can additionally compact the generated files using the
"optimizeTilesets.sh" script.
