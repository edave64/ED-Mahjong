'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a365ca1275e268a356dec594a6a4ad37",
"assets/AssetManifest.bin.json": "0f9f94c07ea4f82455c74b31cce8785a",
"assets/AssetManifest.json": "d92fd8ba14a2d518a0790b8bb685a788",
"assets/assets/backgrounds/dark_wood.desktop": "80452966eeac045039408c82c0a4ac55",
"assets/assets/backgrounds/dark_wood.png": "9c22d225c53cf20192930ec5d31c2478",
"assets/assets/backgrounds/light_wood.desktop": "0ecfd0832a83b70c6f0fc83264f7ee1b",
"assets/assets/backgrounds/light_wood.png": "f8b24ab98262d99b321e2744acd90846",
"assets/assets/backgrounds/wool.desktop": "7f923eb933e517f61048817b6a8be70e",
"assets/assets/backgrounds/wool.png": "f343f3126d89fab191018d324fdbe68e",
"assets/assets/layouts/4_winds.desktop": "26dbb83b4e2388c96fd2a70a9a8be523",
"assets/assets/layouts/4_winds.layout": "f6b9d53f30f51e625954148c9711a01c",
"assets/assets/layouts/alien.desktop": "4a771f2e716e9a34ae588952f153ea70",
"assets/assets/layouts/alien.layout": "03363adc072f94cf208de2b7b7f3de6c",
"assets/assets/layouts/altar.desktop": "ea4dd08a2f7657140707e672efd2b9b3",
"assets/assets/layouts/altar.layout": "7e40f549aa8eb5863d785205f71438b5",
"assets/assets/layouts/arena.desktop": "338b7c2d03541b1fa0d6cd891076a13d",
"assets/assets/layouts/arena.layout": "687223d1395f45565d2cb879e578d3ca",
"assets/assets/layouts/arrow.desktop": "fd7eecdb01b0da261ebce8d3fa66464d",
"assets/assets/layouts/arrow.layout": "fac0e69bf19ad9cfa088089d3a4dc51d",
"assets/assets/layouts/atlantis.desktop": "a24acf992551c0db437e9403d8123767",
"assets/assets/layouts/atlantis.layout": "f013fcf0d56bfa9bf12226c911d19fe1",
"assets/assets/layouts/aztec.desktop": "92311b267220d2b838d58655eeb9f298",
"assets/assets/layouts/aztec.layout": "2e724e349da76c93cb143b9eb5828089",
"assets/assets/layouts/balance.desktop": "7df126a1b9fcb08f2e6cea75c4c45b25",
"assets/assets/layouts/balance.layout": "378ec02f9fe67d9eb239cc3bfe4b9b64",
"assets/assets/layouts/bat.desktop": "c290f042db4c68ff20a292f4561ca891",
"assets/assets/layouts/bat.layout": "50739bedc1784a992c2b8aa8373095f4",
"assets/assets/layouts/bug.desktop": "5f7cb28f0c939dba13b89fcd36afeedd",
"assets/assets/layouts/bug.layout": "8761d78d67d3d6375bb5c0a9c7557116",
"assets/assets/layouts/castle.desktop": "70992673797975365234e09fff6f2fd7",
"assets/assets/layouts/castle.layout": "40452493d9fb3560538ff16afe2f0417",
"assets/assets/layouts/castle2.desktop": "3c0be624600fe6e5e5bfff137bbe5069",
"assets/assets/layouts/castle2.layout": "b46f812e92aabcefba7c5c9e7a8cf804",
"assets/assets/layouts/cat.desktop": "9ce5fdd98e0307d8cb920624e98b2acb",
"assets/assets/layouts/cat.layout": "ab76819553b85541285f581344ddf47e",
"assets/assets/layouts/chains.desktop": "35af4a0df77affdc4e9f5a907b81543d",
"assets/assets/layouts/chains.layout": "fcb48df7ec0b79762af7d4a83ca33991",
"assets/assets/layouts/checkered.desktop": "96807996b9386bf14cb039a76d865bf0",
"assets/assets/layouts/checkered.layout": "86794a3435bb81ecb080ace7eeb92a3e",
"assets/assets/layouts/chip.desktop": "905a021184c8cc5731d59cdf5f7491c3",
"assets/assets/layouts/chip.layout": "e4005949068739a368a74ecff9605463",
"assets/assets/layouts/clubs.desktop": "2f318e84d2383fb65e179960e76d36fb",
"assets/assets/layouts/clubs.layout": "e5c48a3065d15742f84d5e4f90dd53d3",
"assets/assets/layouts/columns.desktop": "43066b775990ae053c2e2c1c62c68156",
"assets/assets/layouts/columns.layout": "912d85d3ff69cf0bafe7c10b6a2c07a0",
"assets/assets/layouts/crab.desktop": "8dd32f37c8ad7919d10f24a491fec7ab",
"assets/assets/layouts/crab.layout": "9ede3aad14173563556428cacbce713d",
"assets/assets/layouts/cross.desktop": "1a1744cdd4c8d2b30b218db8f768d548",
"assets/assets/layouts/cross.layout": "3efe2302c4f438de3bb352d7536a9e95",
"assets/assets/layouts/default.desktop": "9b84def696bec25c7a2e39570675127d",
"assets/assets/layouts/default.layout": "58adde867f6363925becabc29adc229b",
"assets/assets/layouts/dragon.desktop": "012d445c2500134008b12f5b840c014f",
"assets/assets/layouts/dragon.layout": "6cf2ebe458491c5bb6b0783210261d6a",
"assets/assets/layouts/eagle.desktop": "37563cea20451f1fc712d10ded614811",
"assets/assets/layouts/eagle.layout": "3c69ef738c33d973691af7f0e539b708",
"assets/assets/layouts/enterprise.desktop": "c494388e0eec4f1ef2aab8ff86cf558e",
"assets/assets/layouts/enterprise.layout": "65d3b12e80596666a3d2614876f48a75",
"assets/assets/layouts/explosion.desktop": "54587903da20c934595090874e814c0c",
"assets/assets/layouts/explosion.layout": "e0db6f9eed39e8a87f8f177b9b9cb01e",
"assets/assets/layouts/flowers.desktop": "d867dc773c5aae64bd4d2bf8dc2a3e57",
"assets/assets/layouts/flowers.layout": "7c09ad97fa01095b69938cceb83f8f57",
"assets/assets/layouts/future.desktop": "054be51cba00b82a8f596b2626bf6367",
"assets/assets/layouts/future.layout": "aae86e9c61b015bcf58ce52d6be1e557",
"assets/assets/layouts/galaxy.desktop": "7473f21226398739aa02aa2504d2fda3",
"assets/assets/layouts/galaxy.layout": "be8db3d0be93f7e6747359b513930d3b",
"assets/assets/layouts/garden.desktop": "4439e4bfdd78faa00b3cf99870d3ebf8",
"assets/assets/layouts/garden.layout": "31cbcb62f993942b192f53876c14077e",
"assets/assets/layouts/girl.desktop": "a7d3637043652327efa8d2e3c3e6b65d",
"assets/assets/layouts/girl.layout": "7a336b21a3418993b54d2818ae153bad",
"assets/assets/layouts/glade.desktop": "c32c2d0b139849b15c73cd2d1cfc7eb8",
"assets/assets/layouts/glade.layout": "1de762a7c8ea1cc5859f23f0d6f02542",
"assets/assets/layouts/grid.desktop": "9cf5f9312935fd9d091a467d874558f9",
"assets/assets/layouts/grid.layout": "c4e7a3eaf702ac14ab72ce3c5b4a5d82",
"assets/assets/layouts/helios.desktop": "602ad93092a919eabf5371b197a9287c",
"assets/assets/layouts/helios.layout": "2ba0afa1257a6e498418bc6d16f6327a",
"assets/assets/layouts/hole.desktop": "02ea8e86a506a0d23ccf3d8197ad96cb",
"assets/assets/layouts/hole.layout": "c9d77cb2d929ce46ecff1d43d1075488",
"assets/assets/layouts/inner_circle.desktop": "24078697562c313b3cad2b111096797c",
"assets/assets/layouts/inner_circle.layout": "a785a357566d079be4f23afab8fe7ed1",
"assets/assets/layouts/key.desktop": "a687dff0967dc6f473b04cd66fcc8a3a",
"assets/assets/layouts/key.layout": "214874b2111ad6641d7cc2a3416da53b",
"assets/assets/layouts/km.desktop": "0e02b4feb85708250839ab846d8e24df",
"assets/assets/layouts/km.layout": "9dd55ff5ea8c3af3662de09d0a1e2c8f",
"assets/assets/layouts/labyrinth.desktop": "c444ec5fbcc10ec54a12a1d664a66538",
"assets/assets/layouts/labyrinth.layout": "621115f6b119cf4731f903d8cfc42ee8",
"assets/assets/layouts/mask.desktop": "f0b2e0f2fa535fd9e9b9c62150a125d6",
"assets/assets/layouts/mask.layout": "8009f24cb9401e0802d84e0d969117ba",
"assets/assets/layouts/maya.desktop": "fada7acea201b7aa7183d06fca95a8c0",
"assets/assets/layouts/maya.layout": "0eb5c11eec088492ca572fac92c721ad",
"assets/assets/layouts/maze.desktop": "ea15487fb298ce23b30e3fb655232ce2",
"assets/assets/layouts/maze.layout": "8db2f295eb2db4f1ee500261da3556f5",
"assets/assets/layouts/mesh.desktop": "77d75d8fc8d843ae67d46852117182ea",
"assets/assets/layouts/mesh.layout": "f4b5ddebae954744d7f6d0a01a736cde",
"assets/assets/layouts/moth.desktop": "3802b7d53750c403f077944d1a2a4a0e",
"assets/assets/layouts/moth.layout": "6cc3f9506db27d26cfcd02013afe0325",
"assets/assets/layouts/order.desktop": "21e3770e3366ebc3b4c9dcb464c69fea",
"assets/assets/layouts/order.layout": "d7b38e766082009c45386c2cf49a0804",
"assets/assets/layouts/pattern.desktop": "4077eb7dd7697eec90323c85a9c093dd",
"assets/assets/layouts/pattern.layout": "543823834154a7dc680c733cd0fcbce4",
"assets/assets/layouts/penta.desktop": "505688e2a737f5c6c56ad70ef2340206",
"assets/assets/layouts/penta.layout": "2b2a2669bd9a8a86e49c821047662a5c",
"assets/assets/layouts/pillars.desktop": "4c70a00e71c1d761faa70150ab533e3d",
"assets/assets/layouts/pillars.layout": "17dde2142ad77ca2bc6d772db3f0cbe7",
"assets/assets/layouts/pirates.desktop": "add8830c9cd469f390907f00cf2f3c07",
"assets/assets/layouts/pirates.layout": "cee2fec0d7e7c5f176ca37c2a1e53426",
"assets/assets/layouts/pyramid.desktop": "ff43676454c1974e18376cedf50ac438",
"assets/assets/layouts/pyramid.layout": "1b714b503e8a27cd95caee7907d3248a",
"assets/assets/layouts/rocket.desktop": "b7db6d056dbd2bc10b4b7f260faf1cce",
"assets/assets/layouts/rocket.layout": "12788eeac5b64df5ff441897de205675",
"assets/assets/layouts/shield.desktop": "9d1f01ad336feb5d2de4c0479ebdbe02",
"assets/assets/layouts/shield.layout": "1f56ca0d77264629a573e296be6753fc",
"assets/assets/layouts/spider.desktop": "11430c35ac04f566b703a8e7d56c86bd",
"assets/assets/layouts/spider.layout": "8a8275621b7150cc67e71b3a80f5d72e",
"assets/assets/layouts/squares.desktop": "8e2fc5bb0ee3082020e0a441386099df",
"assets/assets/layouts/squares.layout": "16717754c9f1a20f42222399a532b1ef",
"assets/assets/layouts/squaring.desktop": "d9a7dffb53f13870c947180701078a78",
"assets/assets/layouts/squaring.layout": "74c5dbb3e96bf7c2da98be8db36b9717",
"assets/assets/layouts/stadion.desktop": "0c90a898fee732881649a7ad5c85626e",
"assets/assets/layouts/stadion.layout": "29379671c2bf35c73e770668ccbb30f7",
"assets/assets/layouts/stairs.desktop": "d2469de8173a1459f5f53e535b947737",
"assets/assets/layouts/stairs.layout": "10f16b15febf089ac59d7c780c7136d6",
"assets/assets/layouts/star.desktop": "8b9de643085ccdcc4bf5f12ef38f70ba",
"assets/assets/layouts/star.layout": "592879f52e968f613296f571101d9c98",
"assets/assets/layouts/star_ship.desktop": "bb21e696fcdcea87cc56afc31d3b0c97",
"assets/assets/layouts/star_ship.layout": "dc178477c06eef17225b894a9a6654f2",
"assets/assets/layouts/stax.desktop": "0fcd0514d5028ac4cf536c5b1287bc5c",
"assets/assets/layouts/stax.layout": "74f7dec09a17a3ec45ac3d5019b34290",
"assets/assets/layouts/swirl.desktop": "279556cdca573f76d47bc1d12624ee85",
"assets/assets/layouts/swirl.layout": "466e1f3da6cdf813f9c0088797715c8d",
"assets/assets/layouts/temple.desktop": "292281e0bd760e9dbec9846a2e4b3e33",
"assets/assets/layouts/temple.layout": "2dd03a64dcdae28aead2691082a86f49",
"assets/assets/layouts/theatre.desktop": "24e75c427d03c95c870bb09bad942ebd",
"assets/assets/layouts/theatre.layout": "d00556e6db4e0b0a157bf7cacf54002d",
"assets/assets/layouts/the_door.desktop": "c84d87dddf7a5fd1ea2b6d0894c02cc5",
"assets/assets/layouts/the_door.layout": "2790de9ca20bc4b85f1f7cdc8e9fd090",
"assets/assets/layouts/time_tunnel.desktop": "13e471f27ecc61a7fcbbba35154ac8d9",
"assets/assets/layouts/time_tunnel.layout": "475817a171e873abbcd6fbab2c9583c7",
"assets/assets/layouts/tomb.desktop": "2ce632e8bea98fc5990e3e0f4c029372",
"assets/assets/layouts/tomb.layout": "b06ae01d35e9ae31538904bf5b1f1dc3",
"assets/assets/layouts/totem.desktop": "dc9f2627368f7f2f8ef37db022f3057e",
"assets/assets/layouts/totem.layout": "43e9c029755073a75cc00d51445164d6",
"assets/assets/layouts/tower.desktop": "767334bc11e255e600aef35364273b55",
"assets/assets/layouts/tower.layout": "8e364e51f3c4ebc714fbdb49b18f7bab",
"assets/assets/layouts/triangle.desktop": "cc8f829f7bfdb02a660625fb64c994d2",
"assets/assets/layouts/triangle.layout": "b3ca2f8f717d23761a0597274e75ccfe",
"assets/assets/layouts/up&down.desktop": "eebab90d77c7a13bfc3b14fc456cda91",
"assets/assets/layouts/up&down.layout": "180e365c6e99e098013745c4c7f08edc",
"assets/assets/layouts/Vi.desktop": "5b671ec0c9d9c624bb5f808bc09674c4",
"assets/assets/layouts/Vi.layout": "27b8cd442ddb02f41e29e9d67a1328b3",
"assets/assets/layouts/well.desktop": "1195c32676f8275390a6776d2c75105c",
"assets/assets/layouts/well.layout": "8aa278ab828c9d69a8d6bbe372a6b45e",
"assets/assets/layouts/X_shaped.desktop": "01acb9824c91a134f5fd2e783ca29fcf",
"assets/assets/layouts/X_shaped.layout": "4b73160917fc4d5f17c7c3615a9f97fe",
"assets/assets/tilesets/alphabet/BAMBOO_1.png": "923d5ed814a9260913c23e8eb22eeb31",
"assets/assets/tilesets/alphabet/BAMBOO_2.png": "17eeaaaa19d639f12c61e1aac2322e83",
"assets/assets/tilesets/alphabet/BAMBOO_3.png": "941a199157c0998df8623aab267ae4fd",
"assets/assets/tilesets/alphabet/BAMBOO_4.png": "154aa42302187f2ee6f5afd4b1d4aa17",
"assets/assets/tilesets/alphabet/BAMBOO_5.png": "4dcaa33ce4cfa43cef29315c5d498dea",
"assets/assets/tilesets/alphabet/BAMBOO_6.png": "72913682cc53bbd6439f38ff5b3a1bbe",
"assets/assets/tilesets/alphabet/BAMBOO_7.png": "c27efe489d1ef7301ffe51917a073da1",
"assets/assets/tilesets/alphabet/BAMBOO_8.png": "5d35157f8b079c7defa82059d3b3cc4c",
"assets/assets/tilesets/alphabet/BAMBOO_9.png": "6f097c24ecbd49d8ea37348ce1452650",
"assets/assets/tilesets/alphabet/CHARACTER_1.png": "76b731553fa405e51960333189e5016a",
"assets/assets/tilesets/alphabet/CHARACTER_2.png": "8f83a934bde58ac9cec2b8878633b2e4",
"assets/assets/tilesets/alphabet/CHARACTER_3.png": "aea2e6c281f6f67a2cb840b4a441d881",
"assets/assets/tilesets/alphabet/CHARACTER_4.png": "564571c3f4598dccd86a0d3ae6468e8c",
"assets/assets/tilesets/alphabet/CHARACTER_5.png": "5dcf328fef495ee25fbfaf813abb4df7",
"assets/assets/tilesets/alphabet/CHARACTER_6.png": "6135ffa9f2e399bbdbaeb3dfafa19dda",
"assets/assets/tilesets/alphabet/CHARACTER_7.png": "5cb0e6b174091388d9b004dc61946770",
"assets/assets/tilesets/alphabet/CHARACTER_8.png": "63ef4e385fa598f680eac2bb136e179f",
"assets/assets/tilesets/alphabet/CHARACTER_9.png": "136af75dc4b5e98ce64308e3017dce1a",
"assets/assets/tilesets/alphabet/DRAGON_1.png": "406cfd1a85914a18f6a4a93002dbeedf",
"assets/assets/tilesets/alphabet/DRAGON_2.png": "fbea700aa8e4f90f52e468b0c5ac83ed",
"assets/assets/tilesets/alphabet/DRAGON_3.png": "f09506d341ad733c53339800c0950ecc",
"assets/assets/tilesets/alphabet/FLOWER_1.png": "62f9a2b1c7cb65a8e7b00f0f66b44c83",
"assets/assets/tilesets/alphabet/FLOWER_2.png": "62f9a2b1c7cb65a8e7b00f0f66b44c83",
"assets/assets/tilesets/alphabet/FLOWER_3.png": "62f9a2b1c7cb65a8e7b00f0f66b44c83",
"assets/assets/tilesets/alphabet/FLOWER_4.png": "62f9a2b1c7cb65a8e7b00f0f66b44c83",
"assets/assets/tilesets/alphabet/ROD_1.png": "532d4b03449ababc18216857b7ce2298",
"assets/assets/tilesets/alphabet/ROD_2.png": "b24799c96b53601a279cd45fb0dfd591",
"assets/assets/tilesets/alphabet/ROD_3.png": "804fc9ef842cf58c8517d83e39ed7d22",
"assets/assets/tilesets/alphabet/ROD_4.png": "e3a7fdaf08b1e9da15473b7c8ac2b1f2",
"assets/assets/tilesets/alphabet/ROD_5.png": "1d4ebf5ea01b97f17cad20edfb4012a4",
"assets/assets/tilesets/alphabet/ROD_6.png": "4b254fdb5ba87e59b6d8cdc61f2a72e4",
"assets/assets/tilesets/alphabet/ROD_7.png": "e6fd1283e2f57f3a777b2abf3f54f48a",
"assets/assets/tilesets/alphabet/ROD_8.png": "25895e1b5fd746af41923a32165f051a",
"assets/assets/tilesets/alphabet/ROD_9.png": "5ef44cced1e660f9d98814327536bc69",
"assets/assets/tilesets/alphabet/SEASON_1.png": "fbfbb67ebde5aec7fe53dc527acc29f3",
"assets/assets/tilesets/alphabet/SEASON_2.png": "fbfbb67ebde5aec7fe53dc527acc29f3",
"assets/assets/tilesets/alphabet/SEASON_3.png": "d94584dd183a2cfd80138cb50a0ed804",
"assets/assets/tilesets/alphabet/SEASON_4.png": "d94584dd183a2cfd80138cb50a0ed804",
"assets/assets/tilesets/alphabet/TILE_1.png": "7a7daaaa3f22b1bcee966c4682590875",
"assets/assets/tilesets/alphabet/TILE_1_SEL.png": "73a7d157f84f8abc8639bdf3a1578431",
"assets/assets/tilesets/alphabet/WIND_1.png": "a53a6f5009c98b0f19a707322c4fa03c",
"assets/assets/tilesets/alphabet/WIND_2.png": "5c77eaeb5d2f379888de09debf5e222b",
"assets/assets/tilesets/alphabet/WIND_3.png": "c03ed4597304179d4c977ea195d7ac30",
"assets/assets/tilesets/alphabet/WIND_4.png": "cdf3afa9ddf142e37e082967e800097b",
"assets/assets/tilesets/alphabet.copyright": "31e238b85ca106c95a5e0a7eb19b16f1",
"assets/assets/tilesets/alphabet.desktop": "df381b3b2a1ac0212c2659b9e29d3153",
"assets/assets/tilesets/alphabet.svg": "8a77941340a911d5a57a6b3142301925",
"assets/assets/tilesets/bamboo/BAMBOO_1.png": "955ea18042845a8a003514db7526e797",
"assets/assets/tilesets/bamboo/BAMBOO_2.png": "9f6f9ff729657e280fba7a1b1d519833",
"assets/assets/tilesets/bamboo/BAMBOO_3.png": "dbfa1b60f13ba3eb41f97290ec01ba9b",
"assets/assets/tilesets/bamboo/BAMBOO_4.png": "4037c6b9103f62c374a2044c47985616",
"assets/assets/tilesets/bamboo/BAMBOO_5.png": "d7b85d7831741e9429e9dab997540e99",
"assets/assets/tilesets/bamboo/BAMBOO_6.png": "060c4445b75e7e3a6d4058e8cf47cf75",
"assets/assets/tilesets/bamboo/BAMBOO_7.png": "08745229e3ac813a0063e8b2a1664f99",
"assets/assets/tilesets/bamboo/BAMBOO_8.png": "8bf14af1e0df3a1cac9bc95b76723486",
"assets/assets/tilesets/bamboo/BAMBOO_9.png": "8094aaec76efb8960ae1b2d7d2c3f63c",
"assets/assets/tilesets/bamboo/CHARACTER_1.png": "358ac844c902b588d2e8e7ab06aaca89",
"assets/assets/tilesets/bamboo/CHARACTER_2.png": "73adc80b57f69a2c68bd8d137f7573b2",
"assets/assets/tilesets/bamboo/CHARACTER_3.png": "cf670a7ba6c5d7f19cc8736f52d7fdda",
"assets/assets/tilesets/bamboo/CHARACTER_4.png": "4cedcbcb6a572be24cbc88a7f71f869d",
"assets/assets/tilesets/bamboo/CHARACTER_5.png": "8c13e8edf6cb1bad5f13172321021821",
"assets/assets/tilesets/bamboo/CHARACTER_6.png": "13bc2a07e1dc39d4d41131a0d9c060ba",
"assets/assets/tilesets/bamboo/CHARACTER_7.png": "1e3d83760be5abef3b9b36e7184d049f",
"assets/assets/tilesets/bamboo/CHARACTER_8.png": "221efe43e53ed50c47d6ac0145e98370",
"assets/assets/tilesets/bamboo/CHARACTER_9.png": "de960f6f1f1c5d0a39c848eeae97837e",
"assets/assets/tilesets/bamboo/DRAGON_1.png": "dbd6e852ea8adc679b9359ec19d669ad",
"assets/assets/tilesets/bamboo/DRAGON_2.png": "e9ee2801dc753276303561722c613acb",
"assets/assets/tilesets/bamboo/DRAGON_3.png": "0135d4912caa79f086965d2cbbbbbb6f",
"assets/assets/tilesets/bamboo/FLOWER_1.png": "7cf2cec39fcf687092ed3b94ad176e8d",
"assets/assets/tilesets/bamboo/FLOWER_2.png": "6b6b396c3a1c755797748cfb2a60409d",
"assets/assets/tilesets/bamboo/FLOWER_3.png": "6d53f5367d7e77c98491d66715e119ab",
"assets/assets/tilesets/bamboo/FLOWER_4.png": "eb8e9ef324a83c7eb07a25c7bbecfb09",
"assets/assets/tilesets/bamboo/ROD_1.png": "05f088db7ad66ec725d846c1ecc92833",
"assets/assets/tilesets/bamboo/ROD_2.png": "2b92bbd681228cab86a889087b77f6c8",
"assets/assets/tilesets/bamboo/ROD_3.png": "bc198de6add572002bead04bc72a7ed4",
"assets/assets/tilesets/bamboo/ROD_4.png": "4fd1f8de9da821c32be8b9f99d96398f",
"assets/assets/tilesets/bamboo/ROD_5.png": "c05e030b44b079ca7d703941391660fc",
"assets/assets/tilesets/bamboo/ROD_6.png": "c627a8e371a07fbf8af48a15657ea8ab",
"assets/assets/tilesets/bamboo/ROD_7.png": "2cf66c8481854189cc101b7d82633c81",
"assets/assets/tilesets/bamboo/ROD_8.png": "2a534878d0047caa5cb10b5e63120918",
"assets/assets/tilesets/bamboo/ROD_9.png": "d9230dc91bf1ab8fbb53d9108355eeb5",
"assets/assets/tilesets/bamboo/SEASON_1.png": "83756529ea55e7153e5252d2dd6260a4",
"assets/assets/tilesets/bamboo/SEASON_2.png": "83fc38b31ca5f58fc7691103c7719718",
"assets/assets/tilesets/bamboo/SEASON_3.png": "a66e50f8227198441c58a172de1d325f",
"assets/assets/tilesets/bamboo/SEASON_4.png": "6efa3705dcf062e61c1fc1e82000ea8a",
"assets/assets/tilesets/bamboo/TILE_1.png": "32f0d380cab321e38cc4939eadbf6e27",
"assets/assets/tilesets/bamboo/TILE_1_SEL.png": "3435ef056cdbe884313e4968317b6517",
"assets/assets/tilesets/bamboo/WIND_1.png": "4d6b2b9863897f0d0dba168bc7121bc9",
"assets/assets/tilesets/bamboo/WIND_2.png": "cfbdbddecf9762abddfd3642b860bd1a",
"assets/assets/tilesets/bamboo/WIND_3.png": "f4efe1a9d2b33ce4675f7898d2ce8b14",
"assets/assets/tilesets/bamboo/WIND_4.png": "ad440517bbdd236df8d4589dacf2ce37",
"assets/assets/tilesets/bamboo.copyright": "ec6b145fcf2847df97cfd67193038d63",
"assets/assets/tilesets/bamboo.desktop": "ab378adc81cfb03e741ea1bd97e4e6a4",
"assets/assets/tilesets/bamboo.svg": "f2fee1e1bf464db68dd39d4ddd7067d9",
"assets/assets/tilesets/classic/BAMBOO_1.png": "2e15b0f0e0eac3c5e10c7d9334d1493f",
"assets/assets/tilesets/classic/BAMBOO_2.png": "602ad81a2184497c60a5185c4f85627e",
"assets/assets/tilesets/classic/BAMBOO_3.png": "74dfe8fe3426af98c8e5ad2a9a707f8c",
"assets/assets/tilesets/classic/BAMBOO_4.png": "c9b103065f58cbba95504e50f752a9e4",
"assets/assets/tilesets/classic/BAMBOO_5.png": "7ae7dc9fed88d0bd9ddb599718629ec9",
"assets/assets/tilesets/classic/BAMBOO_6.png": "56b16a1571daa5ceac0bcf7e78718172",
"assets/assets/tilesets/classic/BAMBOO_7.png": "0fcd78528b084875b86783375d303093",
"assets/assets/tilesets/classic/BAMBOO_8.png": "87c51ce588d48ebbe81a0c06e4f6168a",
"assets/assets/tilesets/classic/BAMBOO_9.png": "b638fdf195aa6da6cea5b67d44543f83",
"assets/assets/tilesets/classic/CHARACTER_1.png": "812c47bd70f0b2ec8653b2acb404a439",
"assets/assets/tilesets/classic/CHARACTER_2.png": "24a8c91164e2ab2d465e54763184e97f",
"assets/assets/tilesets/classic/CHARACTER_3.png": "0da57be2f58b79cc78220c5e47543111",
"assets/assets/tilesets/classic/CHARACTER_4.png": "dfa45c1de226f464bfa7911f58f2505c",
"assets/assets/tilesets/classic/CHARACTER_5.png": "66ac58c452662a2b7b0bd0136b9a3e0b",
"assets/assets/tilesets/classic/CHARACTER_6.png": "c87a292ac6ee4c8e8f1ef4e7ce57a8cf",
"assets/assets/tilesets/classic/CHARACTER_7.png": "78293961bf7969696db5287ac23aeb71",
"assets/assets/tilesets/classic/CHARACTER_8.png": "9c8e7330ba0ac6670baec985c744bb84",
"assets/assets/tilesets/classic/CHARACTER_9.png": "7b512a67eef88ac83dd76b1818d5f834",
"assets/assets/tilesets/classic/DRAGON_1.png": "dcc114930e87c4ae4803824facde57a1",
"assets/assets/tilesets/classic/DRAGON_2.png": "5424e914364748571ea4596b7a07daf5",
"assets/assets/tilesets/classic/DRAGON_3.png": "60c3a7256fef52d7574e7618fdc52546",
"assets/assets/tilesets/classic/FLOWER_1.png": "4bf128fe495b8b59ad2ca9d116dc0ac5",
"assets/assets/tilesets/classic/FLOWER_2.png": "9e9245127682d26f73c34f558f4b2250",
"assets/assets/tilesets/classic/FLOWER_3.png": "e27b0e7219539dad83aea4dcd7fbaeeb",
"assets/assets/tilesets/classic/FLOWER_4.png": "00078b988aec92558c575f03783f8425",
"assets/assets/tilesets/classic/ROD_1.png": "a10f669456b1ae2ace5a7b36ed1791b8",
"assets/assets/tilesets/classic/ROD_2.png": "9d801ce183f0e2037e2e8582b11cccc5",
"assets/assets/tilesets/classic/ROD_3.png": "8f7247f8be5ba76d841e44aad6a5883d",
"assets/assets/tilesets/classic/ROD_4.png": "8f4800f1add8884da009530c2ca08a62",
"assets/assets/tilesets/classic/ROD_5.png": "c5eca5873db6594e7601c494a386009f",
"assets/assets/tilesets/classic/ROD_6.png": "21b38704bbab8707d263246eb8b02cd5",
"assets/assets/tilesets/classic/ROD_7.png": "411271af8808810af764da9985fce76c",
"assets/assets/tilesets/classic/ROD_8.png": "c74673ef5825c6514d20a1a01a06c354",
"assets/assets/tilesets/classic/ROD_9.png": "22909b973bc5e89080e94b392a03c864",
"assets/assets/tilesets/classic/SEASON_1.png": "40d5338f9d8ab8d3e7e646e11b36e82a",
"assets/assets/tilesets/classic/SEASON_2.png": "1572d78a90dc126f9863a3d41171f1b7",
"assets/assets/tilesets/classic/SEASON_3.png": "d605ddcfa2b5c1749fcb5b1cf92037ab",
"assets/assets/tilesets/classic/SEASON_4.png": "e1921b83c912c1b4435fc1216d19f3ae",
"assets/assets/tilesets/classic/TILE_1.png": "d4fc4630ca6c37a7dedacde169f09fed",
"assets/assets/tilesets/classic/TILE_1_SEL.png": "ad9515bd73d2e461e7ac411a9f41b640",
"assets/assets/tilesets/classic/WIND_1.png": "1a06abe9d1bb559bd95f3a2d9e18ac09",
"assets/assets/tilesets/classic/WIND_2.png": "5848fd142eda757d96ab292e55ed61f5",
"assets/assets/tilesets/classic/WIND_3.png": "363696bb760ae1e1ff2c559b2b611045",
"assets/assets/tilesets/classic/WIND_4.png": "5d172460c7e99e216c1b6c8fee5200ae",
"assets/assets/tilesets/classic.copyright": "fba007cc2e313f8ed89de4789631e399",
"assets/assets/tilesets/classic.desktop": "62762167d737ae7e32719eca781fd600",
"assets/assets/tilesets/classic.svg": "4eff258e9d693e485bd8bd65dad64f47",
"assets/assets/tilesets/default/BAMBOO_1.png": "9917bed0bb448f3dc4a9ca624d87d9f1",
"assets/assets/tilesets/default/BAMBOO_2.png": "44bb8e570ca5fb90506aac6b6cf456bc",
"assets/assets/tilesets/default/BAMBOO_3.png": "9acf381d7b99a417f6255c25ed0b268c",
"assets/assets/tilesets/default/BAMBOO_4.png": "3e90cb2568ea5ed56cd7adfd3d819fdd",
"assets/assets/tilesets/default/BAMBOO_5.png": "ed9af6eb3250a89b7c71ba9c7873f686",
"assets/assets/tilesets/default/BAMBOO_6.png": "0ab4ded1b822137fcb5386b56b9d9874",
"assets/assets/tilesets/default/BAMBOO_7.png": "9bcabc4a37b73e63200d4b416708d657",
"assets/assets/tilesets/default/BAMBOO_8.png": "f120ae1441daef00420219c4d7c17484",
"assets/assets/tilesets/default/BAMBOO_9.png": "b8cc0f8e5120a2a31b251c25ffb2d93a",
"assets/assets/tilesets/default/CHARACTER_1.png": "a41416d86bab703da11f356aca54efe3",
"assets/assets/tilesets/default/CHARACTER_2.png": "d5e58578405fc3b0be0c56a9d4c8a694",
"assets/assets/tilesets/default/CHARACTER_3.png": "adde1cf9111bb23b71557bc68c841386",
"assets/assets/tilesets/default/CHARACTER_4.png": "7e59edb26deef889c1af677aae81ea1d",
"assets/assets/tilesets/default/CHARACTER_5.png": "f751a7df1fad93c5b41977f7a5e5f99f",
"assets/assets/tilesets/default/CHARACTER_6.png": "ed9f7d4931391f3a19a6926a48a75a4c",
"assets/assets/tilesets/default/CHARACTER_7.png": "8bff6c5814a6697fa290fb36396c0801",
"assets/assets/tilesets/default/CHARACTER_8.png": "2185f93b400645fd9cc162638f492697",
"assets/assets/tilesets/default/CHARACTER_9.png": "8eddaa2eb4c72bd96cef5f02ebe7c5dd",
"assets/assets/tilesets/default/DRAGON_1.png": "27a22aea8c7fa8220644bfd124fbe39c",
"assets/assets/tilesets/default/DRAGON_2.png": "d475c0b81a2a62948394675924e0607e",
"assets/assets/tilesets/default/DRAGON_3.png": "4b4438ec8d5c1bb0f5e103d370b7c560",
"assets/assets/tilesets/default/FLOWER_1.png": "fe3e7fe33ecf9c120c277e67bce838f4",
"assets/assets/tilesets/default/FLOWER_2.png": "2c40c3e8df8da110756b7a62398f0235",
"assets/assets/tilesets/default/FLOWER_3.png": "a9fba4b21f7069c95b2cdf5151c06263",
"assets/assets/tilesets/default/FLOWER_4.png": "a803cf1fb54e23f8fb25c56e87124aaf",
"assets/assets/tilesets/default/ROD_1.png": "bf1ede59c72f07c2efe5b21309cf8de8",
"assets/assets/tilesets/default/ROD_2.png": "56f8986cd915379fdf23f93dcf922453",
"assets/assets/tilesets/default/ROD_3.png": "a086d7e4d3bbfea639357de1d5765ae2",
"assets/assets/tilesets/default/ROD_4.png": "671467dc4c95c7fc0df07181c0116d7e",
"assets/assets/tilesets/default/ROD_5.png": "91c084966ab79720c2ef94a72077692a",
"assets/assets/tilesets/default/ROD_6.png": "a6f855b90c413c9a4d34aa14a496c31f",
"assets/assets/tilesets/default/ROD_7.png": "304aa87f14cd2cfaa9502c3c674b387a",
"assets/assets/tilesets/default/ROD_8.png": "3c8dcaf2536f20a5a8a7c2c662f7a7e8",
"assets/assets/tilesets/default/ROD_9.png": "95c4106d4c730652d01cfb282e8a1201",
"assets/assets/tilesets/default/SEASON_1.png": "a8de0ff02e8306773c9526ab5ed315f4",
"assets/assets/tilesets/default/SEASON_2.png": "c113414d8596e4ddefe633edbe64cffe",
"assets/assets/tilesets/default/SEASON_3.png": "2085dd7b2652f978f0f81bbd625e0d4c",
"assets/assets/tilesets/default/SEASON_4.png": "cc2fbb0b1f20cffb87b5b8925de28a33",
"assets/assets/tilesets/default/TILE_1.png": "23b51eee99a9a5c7198c9ef39e9dc6f5",
"assets/assets/tilesets/default/TILE_1_SEL.png": "cf1fe09c93c8b8c08bc4d7de78517305",
"assets/assets/tilesets/default/WIND_1.png": "9c36a7262bf526a311dac633aff859a9",
"assets/assets/tilesets/default/WIND_2.png": "0b4ff9f9325d1e0a178d2832eddc3b85",
"assets/assets/tilesets/default/WIND_3.png": "41df0b91734feb23a5b61b01ba1df54d",
"assets/assets/tilesets/default/WIND_4.png": "ffe611e7ca00a41ded4826d4f945244f",
"assets/assets/tilesets/default.copyright": "9ef21b37c716709ae18af9c48c2bca39",
"assets/assets/tilesets/default.desktop": "700abdf3202c18d4b8045e7e269facbf",
"assets/assets/tilesets/default.svg": "062c34aa0b73c997356c2e7eb9c4451c",
"assets/assets/tilesets/egypt/BAMBOO_1.png": "05ac5bf8e493f48df92494f94c251217",
"assets/assets/tilesets/egypt/BAMBOO_2.png": "8fc83c8e440f692bd5f25f63c5860a63",
"assets/assets/tilesets/egypt/BAMBOO_3.png": "92b7558a5762d2a225780eb896df73ca",
"assets/assets/tilesets/egypt/BAMBOO_4.png": "f469369717a2dd51405ed08f06827e3b",
"assets/assets/tilesets/egypt/BAMBOO_5.png": "bf3e313780238b2bdaccca615b2e7d8f",
"assets/assets/tilesets/egypt/BAMBOO_6.png": "6d024376bced73d79286cfc80dbb1b0a",
"assets/assets/tilesets/egypt/BAMBOO_7.png": "0208796c3fa884b2a4a97ce94a7f5e84",
"assets/assets/tilesets/egypt/BAMBOO_8.png": "7b14c62de3ed02a0b3efcfb88243122d",
"assets/assets/tilesets/egypt/BAMBOO_9.png": "fc1202b4167c49278ef116222c90cf7f",
"assets/assets/tilesets/egypt/CHARACTER_1.png": "12db7eb8c8ea773af14c9203ff68e8c4",
"assets/assets/tilesets/egypt/CHARACTER_2.png": "52dec20b69623ec89d2e852bd8665973",
"assets/assets/tilesets/egypt/CHARACTER_3.png": "b91a62615c04d74f995918bd2d62bfb7",
"assets/assets/tilesets/egypt/CHARACTER_4.png": "afa2a7b5022c56ce48b87bcac743fb9b",
"assets/assets/tilesets/egypt/CHARACTER_5.png": "47b3138d52e4d13767154f1226932644",
"assets/assets/tilesets/egypt/CHARACTER_6.png": "43127ca4c0d7ff45b06477ff48759225",
"assets/assets/tilesets/egypt/CHARACTER_7.png": "bd22d57a84f5fc410ed4a65cf432e51b",
"assets/assets/tilesets/egypt/CHARACTER_8.png": "2dcfe3d77d8b18fc75b95f0ece8d83e9",
"assets/assets/tilesets/egypt/CHARACTER_9.png": "83083f02b9ac86b1d8972d23f3e5dca2",
"assets/assets/tilesets/egypt/DRAGON_1.png": "2ac012c1e8f5ccf6b3b2bfa7ba374f4f",
"assets/assets/tilesets/egypt/DRAGON_2.png": "606b8f9501ce0c3dfe3382f1f2e71faf",
"assets/assets/tilesets/egypt/DRAGON_3.png": "8947dd1440cc7c8c360facbeea76f363",
"assets/assets/tilesets/egypt/FLOWER_1.png": "bb03a77b500e1b7fb95404ad06672559",
"assets/assets/tilesets/egypt/FLOWER_2.png": "a4ac0270232cb0919521bd47b5b2854e",
"assets/assets/tilesets/egypt/FLOWER_3.png": "d9825bda5a0787f4501fac06dc1abb9c",
"assets/assets/tilesets/egypt/FLOWER_4.png": "90e8bb659c4283828efdb7a618bee980",
"assets/assets/tilesets/egypt/ROD_1.png": "b23a39ccf7bf789e317fd29d96714927",
"assets/assets/tilesets/egypt/ROD_2.png": "4b5f9770c813330f1fdfded12a2ce4a7",
"assets/assets/tilesets/egypt/ROD_3.png": "ae13c16aa80d384f5684d63cc0132345",
"assets/assets/tilesets/egypt/ROD_4.png": "4686eb6e22ea925ddb23934b26f49cdc",
"assets/assets/tilesets/egypt/ROD_5.png": "96c286379e3efc052493b0a30bbf5376",
"assets/assets/tilesets/egypt/ROD_6.png": "70bdbec36129af88aeec567c6ac0d058",
"assets/assets/tilesets/egypt/ROD_7.png": "64a3085ccd1ef4bd8ea7ffd6a1d2c00c",
"assets/assets/tilesets/egypt/ROD_8.png": "1f38ef3edd98bc7428a9b0016744a737",
"assets/assets/tilesets/egypt/ROD_9.png": "44a0a81d14221b3d70410e8d9c44a6b9",
"assets/assets/tilesets/egypt/SEASON_1.png": "83b7342993733e45a48e54c9d7658270",
"assets/assets/tilesets/egypt/SEASON_2.png": "d99b9bf1ada687f3ca3bb83bd96af140",
"assets/assets/tilesets/egypt/SEASON_3.png": "3ff55a4d43a3af645e15f484bea64ab9",
"assets/assets/tilesets/egypt/SEASON_4.png": "bd5f5345f772450ce7730a3e6de073a0",
"assets/assets/tilesets/egypt/TILE_1.png": "087242e15d452df1b460c542ad9a285a",
"assets/assets/tilesets/egypt/TILE_1_SEL.png": "a325456b87684c6a463c1bbf1d5ab203",
"assets/assets/tilesets/egypt/WIND_1.png": "472fb2c843a99f03cd727ad6296718cf",
"assets/assets/tilesets/egypt/WIND_2.png": "3ced75ae8ac4844ffa33fd6051458407",
"assets/assets/tilesets/egypt/WIND_3.png": "587a946fda24a07f9ab0a1008e0f1c18",
"assets/assets/tilesets/egypt/WIND_4.png": "20e927b1c3825d4f6e482ac7d6538132",
"assets/assets/tilesets/egypt.copyright": "fb08f9add7b0f577977b1f0203d4f7a4",
"assets/assets/tilesets/egypt.desktop": "424ed298ca3660c455ef5faf79e3ab51",
"assets/assets/tilesets/egypt.svg": "c8e48af4a2d9d7c6f83229a4ec44a488",
"assets/assets/tilesets/jade/BAMBOO_1.png": "337d1954aff54f4a595afca3f94d0424",
"assets/assets/tilesets/jade/BAMBOO_2.png": "1bbfb7babccaf89e98ae208c409b44c6",
"assets/assets/tilesets/jade/BAMBOO_3.png": "51177f92dc2114e8e524b65f80a257a8",
"assets/assets/tilesets/jade/BAMBOO_4.png": "88928cf6829dcdde33855b63396c1dfa",
"assets/assets/tilesets/jade/BAMBOO_5.png": "cfe01a5f07c0d553fa612c204991abe1",
"assets/assets/tilesets/jade/BAMBOO_6.png": "535035c5a0dea92c07b647cbedf9a2c5",
"assets/assets/tilesets/jade/BAMBOO_7.png": "3cbd26d393036774c6df5f4d44094c75",
"assets/assets/tilesets/jade/BAMBOO_8.png": "30f158e4926bd0997b599810fa566a13",
"assets/assets/tilesets/jade/BAMBOO_9.png": "30900202a874649c280d3c7899d84b6f",
"assets/assets/tilesets/jade/CHARACTER_1.png": "696819b9766a64fca301162a5278904e",
"assets/assets/tilesets/jade/CHARACTER_2.png": "49d3f271a11f1985baa7e695bdcafb82",
"assets/assets/tilesets/jade/CHARACTER_3.png": "adb523a03aa7bf6e9eab3c37ac8e429c",
"assets/assets/tilesets/jade/CHARACTER_4.png": "5b17cba969e04d7b10da9fc89f8b1720",
"assets/assets/tilesets/jade/CHARACTER_5.png": "445eca92177f58fd45fef1d8d902b937",
"assets/assets/tilesets/jade/CHARACTER_6.png": "eb830be07fd27daff136b1b3efa8d0fc",
"assets/assets/tilesets/jade/CHARACTER_7.png": "ec2c4423c99521ae82b0e06f692be1e7",
"assets/assets/tilesets/jade/CHARACTER_8.png": "d172bf6b24381893b911581419eb286d",
"assets/assets/tilesets/jade/CHARACTER_9.png": "528b319d99d5f84a13fa2d35548a9aea",
"assets/assets/tilesets/jade/DRAGON_1.png": "76a346c0db20b858c2dfdea3eb830415",
"assets/assets/tilesets/jade/DRAGON_2.png": "07ee69ecca86f05147c0b2954aeda06e",
"assets/assets/tilesets/jade/DRAGON_3.png": "110d94474119589caf36f8c90c59f878",
"assets/assets/tilesets/jade/FLOWER_1.png": "19e297da4586c884fe62c73b913dabe0",
"assets/assets/tilesets/jade/FLOWER_2.png": "64a74967e01e598fae0abe9903a88cbb",
"assets/assets/tilesets/jade/FLOWER_3.png": "5682b47bfce99d4f19179e9423a74152",
"assets/assets/tilesets/jade/FLOWER_4.png": "7512011cdde0061bf1175f9a7b7cd3ba",
"assets/assets/tilesets/jade/ROD_1.png": "4d3769972fd8f9fe104f5a2e47a12958",
"assets/assets/tilesets/jade/ROD_2.png": "3d8a75be2061b722017910038268696e",
"assets/assets/tilesets/jade/ROD_3.png": "1e16dd35febdefd92e54addc9c830c1d",
"assets/assets/tilesets/jade/ROD_4.png": "a099b0b6904fe8194240aaacf3b7727e",
"assets/assets/tilesets/jade/ROD_5.png": "fb8efdf46bca046ead30c31808ebe353",
"assets/assets/tilesets/jade/ROD_6.png": "4fecd39a457bef5161a6ac4b94d98cce",
"assets/assets/tilesets/jade/ROD_7.png": "60c8673d761a0654cba234d8d0269748",
"assets/assets/tilesets/jade/ROD_8.png": "dd678ca471bd7aa8f08b4d81e28473a8",
"assets/assets/tilesets/jade/ROD_9.png": "efa97e131ff875a4c26c915b1d889942",
"assets/assets/tilesets/jade/SEASON_1.png": "d15f989506816887a3bf199d15ec89a3",
"assets/assets/tilesets/jade/SEASON_2.png": "b27e0ee7c3625bb9bdf49b4cec2d227d",
"assets/assets/tilesets/jade/SEASON_3.png": "582d6bd7cb64cfeaad2fce21426ca8e0",
"assets/assets/tilesets/jade/SEASON_4.png": "6567fed6f45edb6ef84d170ce035ed68",
"assets/assets/tilesets/jade/TILE_1.png": "dbc5cab1eb5754aa590366aec95aaffe",
"assets/assets/tilesets/jade/TILE_1_SEL.png": "50cbcc0c57db12070a39a952c240f223",
"assets/assets/tilesets/jade/WIND_1.png": "fc5b72e498c9a834fff861c85061ff40",
"assets/assets/tilesets/jade/WIND_2.png": "a14721dabcd936fc048ff51ff20364aa",
"assets/assets/tilesets/jade/WIND_3.png": "d4ea5beed3afe435bb215c9e726faaca",
"assets/assets/tilesets/jade/WIND_4.png": "27fa321b2063dc12ff64f11cecba6920",
"assets/assets/tilesets/jade.copyright": "8b858d7c5d8282055f4ffae897e21cb7",
"assets/assets/tilesets/jade.desktop": "9496dc89e0563253706d670d583f9718",
"assets/assets/tilesets/jade.svg": "6c8ce3db379494db9cc112a6d8d20e8e",
"assets/assets/tilesets/traditional/BAMBOO_1.png": "2e047f03a77a62bf0f0ac60abcf3f8e9",
"assets/assets/tilesets/traditional/BAMBOO_2.png": "454d354716afadb09cd85a4fb13884a2",
"assets/assets/tilesets/traditional/BAMBOO_3.png": "e6136a8dc270e0d3f16f0b050d6d4ac2",
"assets/assets/tilesets/traditional/BAMBOO_4.png": "29103b17002870afd71d8bef75c9f4d7",
"assets/assets/tilesets/traditional/BAMBOO_5.png": "544fa46f77a9e18b02cbea925ab20132",
"assets/assets/tilesets/traditional/BAMBOO_6.png": "ebd75470c0f052c9cb5e4169f627dc52",
"assets/assets/tilesets/traditional/BAMBOO_7.png": "ae2e694abad9fc857a0c5ce33d036537",
"assets/assets/tilesets/traditional/BAMBOO_8.png": "72749f3fdbc53739de22dbec37bc119f",
"assets/assets/tilesets/traditional/BAMBOO_9.png": "b44a199ed6570d6913c52eda160bbb60",
"assets/assets/tilesets/traditional/CHARACTER_1.png": "1c2eed4c552d864d3a9fed094ad8ba57",
"assets/assets/tilesets/traditional/CHARACTER_2.png": "ce244561838f4440b4697376ecbf4c9b",
"assets/assets/tilesets/traditional/CHARACTER_3.png": "cae3d6c5b35b701faaa96afd04eeba55",
"assets/assets/tilesets/traditional/CHARACTER_4.png": "e6dfcb23f20aeedcf3c5c811dc90291f",
"assets/assets/tilesets/traditional/CHARACTER_5.png": "1311174afca8f6b5b79549c1194e2f54",
"assets/assets/tilesets/traditional/CHARACTER_6.png": "54942bb68747b7ecab425ce56af8caea",
"assets/assets/tilesets/traditional/CHARACTER_7.png": "8b94794889ef1d30eb6d4be9e6a397be",
"assets/assets/tilesets/traditional/CHARACTER_8.png": "6a3cb0f18abee34723d15d949ca8a3ea",
"assets/assets/tilesets/traditional/CHARACTER_9.png": "701bfae3807f1a914579b233565d5ded",
"assets/assets/tilesets/traditional/DRAGON_1.png": "0e251d71e4538273692292a010644614",
"assets/assets/tilesets/traditional/DRAGON_2.png": "5bb8c5f07aba830c82e9903f20cd2095",
"assets/assets/tilesets/traditional/DRAGON_3.png": "40e02bf25c13a7f48a31baad12eeba18",
"assets/assets/tilesets/traditional/FLOWER_1.png": "c87aefa13452f7d92a06eb0639de0bd7",
"assets/assets/tilesets/traditional/FLOWER_2.png": "cf2128630cafae14b560169400e0fd4d",
"assets/assets/tilesets/traditional/FLOWER_3.png": "cafd5dab681422360ac287f4f4a620c4",
"assets/assets/tilesets/traditional/FLOWER_4.png": "b9e83e1f0d6151292bff9d017c599bac",
"assets/assets/tilesets/traditional/ROD_1.png": "64e8822c940878b936effd75250fe790",
"assets/assets/tilesets/traditional/ROD_2.png": "38cbe36f03b26da1f29f3d3668e8b6f0",
"assets/assets/tilesets/traditional/ROD_3.png": "668bfea57aadec0bffaf37985742f1a6",
"assets/assets/tilesets/traditional/ROD_4.png": "22972ff31d7b2835b80490d3b1bdd172",
"assets/assets/tilesets/traditional/ROD_5.png": "644bc1958cc8c626a277cf1a59722fc3",
"assets/assets/tilesets/traditional/ROD_6.png": "c68825cd0b7b92ff1b81f3ee7897ca1a",
"assets/assets/tilesets/traditional/ROD_7.png": "d19fb42dcd7bb2308f7e650d7334d5b9",
"assets/assets/tilesets/traditional/ROD_8.png": "4996c528650d5dd7d3dace546f3533da",
"assets/assets/tilesets/traditional/ROD_9.png": "3ee1af3c2e7c8facb65cc64fa590790b",
"assets/assets/tilesets/traditional/SEASON_1.png": "bc055670389cb67eaf76a4cf03778c4b",
"assets/assets/tilesets/traditional/SEASON_2.png": "2e9afbfd91afd192007ed8caef9b5f0b",
"assets/assets/tilesets/traditional/SEASON_3.png": "ab1d6e1d2d1495fe1a1ad63dc985c8a5",
"assets/assets/tilesets/traditional/SEASON_4.png": "ac59f14d70f09e39369c943c3da4197b",
"assets/assets/tilesets/traditional/TILE_1.png": "795ab33300072d9ef1a9b88a476d0ffd",
"assets/assets/tilesets/traditional/TILE_1_SEL.png": "84725dc28e34be8c6f1340f18d31d394",
"assets/assets/tilesets/traditional/WIND_1.png": "c838cf62c9487ca8f01a3804b3dac8b7",
"assets/assets/tilesets/traditional/WIND_2.png": "45dc1196a936700eba49104d130a46ba",
"assets/assets/tilesets/traditional/WIND_3.png": "d28200a8968400d67018e4dd8590be26",
"assets/assets/tilesets/traditional/WIND_4.png": "83a48b40001be5fb1b3a07c280f90fa9",
"assets/assets/tilesets/traditional.copyright": "971b8a52a8b0949e54211ffcbb233ad9",
"assets/assets/tilesets/traditional.desktop": "4453c6e364bf85de832bedcab03a1b16",
"assets/assets/tilesets/traditional.svg": "25d58deaaaca0229cacc28557d656174",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "67a7ec2c33992a6f40d9bcca5e54db68",
"assets/NOTICES": "49398c7eb44cbcc2d17d6560d7ab6b6f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "f43b565df0683d85c0aa8aa7294f491c",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ff59ee9a5c48113e63c3630f800742ac",
"icons/Icon-512.png": "542b2558a29e93d3d0fe36c59c0b6028",
"index.html": "b22fe92d9330c62cc281cbf80d5aed49",
"/": "b22fe92d9330c62cc281cbf80d5aed49",
"main.dart.js": "0a3b62f70b7c9da3029c1ae154c0f349",
"manifest.json": "90b4ddb8003813d39448b7c7b616a02c",
"version.json": "27aca16a038e083611f7e1d993036de3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
