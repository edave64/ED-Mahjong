cd "./assets/tilesets/$1/" || exit

optipng -o7 ./*.png
mkdir z
zopflipng --prefix=z/ ./*.png
mv -f ./z/* ./
rmdir z
