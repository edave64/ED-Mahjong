'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "d92fd8ba14a2d518a0790b8bb685a788",
"assets/assets/backgrounds/dark_wood.desktop": "0361c308e1b12518b299acddac47cec2",
"assets/assets/backgrounds/dark_wood.png": "9c22d225c53cf20192930ec5d31c2478",
"assets/assets/backgrounds/light_wood.desktop": "3dadeef8a55632ad4168196ca2678a13",
"assets/assets/backgrounds/light_wood.png": "f8b24ab98262d99b321e2744acd90846",
"assets/assets/backgrounds/wool.desktop": "c2b3bc340e1c8dcbe93c10a505ce6485",
"assets/assets/backgrounds/wool.png": "f343f3126d89fab191018d324fdbe68e",
"assets/assets/layouts/4_winds.desktop": "c8869500232fa4dc46379fd5c4958a75",
"assets/assets/layouts/4_winds.layout": "699a24406a54b66b6d40266fa2d94ee2",
"assets/assets/layouts/alien.desktop": "7307e87e8f40e2741955259746edf94d",
"assets/assets/layouts/alien.layout": "0ca4a5106863ca17d4e905e55fc11978",
"assets/assets/layouts/altar.desktop": "3fe8b9180960333fb7807da6705c6445",
"assets/assets/layouts/altar.layout": "36c8f5c27a46bfaf806a63eb1089f7bb",
"assets/assets/layouts/arena.desktop": "85c5d788c76c8215b650c5ebe88c1928",
"assets/assets/layouts/arena.layout": "2b82c8fa50178c7194ebf5d03f9634e4",
"assets/assets/layouts/arrow.desktop": "943a2953b891bbe32c50f3b79bec6c4c",
"assets/assets/layouts/arrow.layout": "344c442de454a5e56f27a57c3bfad25a",
"assets/assets/layouts/atlantis.desktop": "b4f7c89e372d375f1c317cf30e5e1a0a",
"assets/assets/layouts/atlantis.layout": "86233e58f974aced218b01e73c0c10ca",
"assets/assets/layouts/aztec.desktop": "e94dd87674ae26606aae66b90c963410",
"assets/assets/layouts/aztec.layout": "9e5bba8fede147963b563aef4d0bfd70",
"assets/assets/layouts/balance.desktop": "098637bae1d6b3b09c0ed173ca1587f6",
"assets/assets/layouts/balance.layout": "3f05a84d5e844d135f8414fd35e7f1a8",
"assets/assets/layouts/bat.desktop": "4c1b19f678f655945af3a08acf1748b9",
"assets/assets/layouts/bat.layout": "802c7c506ed16bece92a8dea741707d6",
"assets/assets/layouts/bug.desktop": "d7eb7c8108dc4eabd237ea3c3994beed",
"assets/assets/layouts/bug.layout": "942ed9f2e0c8b79f1540711181b164a9",
"assets/assets/layouts/castle.desktop": "fa5177b53d7b7190dfaaf0edccc1fe8e",
"assets/assets/layouts/castle.layout": "69c827b9bef7a9b07fb2c9812d3e32d4",
"assets/assets/layouts/castle2.desktop": "5c20532de61927e193a0d2f46c6f39da",
"assets/assets/layouts/castle2.layout": "450397e1decb722742e724a15d17f101",
"assets/assets/layouts/cat.desktop": "26682b0b56373131ce91cd4d5d091e2a",
"assets/assets/layouts/cat.layout": "d79ae3c9fb5944372780ffecb7bd82ad",
"assets/assets/layouts/chains.desktop": "cf30ab88d060a68c532e3d10fc161302",
"assets/assets/layouts/chains.layout": "88ef400ed8f293f0253591ce29067748",
"assets/assets/layouts/checkered.desktop": "08e1e6b8c6500de5c2fe3467ccfcfa5c",
"assets/assets/layouts/checkered.layout": "48147f4c4a7bfa54ea436c9f23644f18",
"assets/assets/layouts/chip.desktop": "39df80e41d52592ad795cc092947b9c2",
"assets/assets/layouts/chip.layout": "fea5e807bb4cfb7b4d401ae5b2b23c5d",
"assets/assets/layouts/clubs.desktop": "ff87aa0ada65158e6c49532a412ed659",
"assets/assets/layouts/clubs.layout": "21a8fa4025919e9185e7eb6096539a57",
"assets/assets/layouts/columns.desktop": "da82fc171c85d25de1b510dd35c4ad24",
"assets/assets/layouts/columns.layout": "9018bc08affb4f42b3c270024dc8b4c7",
"assets/assets/layouts/crab.desktop": "47f8e514f37c20cfafb31ab38fa52d21",
"assets/assets/layouts/crab.layout": "6048bae9a98d5d6146858d2167887f18",
"assets/assets/layouts/cross.desktop": "bf910bbc1262540568a92c0ebac45ace",
"assets/assets/layouts/cross.layout": "f4fdd8204a1eaf460ca1416fbbe75c4c",
"assets/assets/layouts/default.desktop": "c03c5e0085583fb145f7b2120fa9976d",
"assets/assets/layouts/default.layout": "e1752e3b46a84cca766847afd12f4f67",
"assets/assets/layouts/dragon.desktop": "81bf04c45e1ac987d7518f8eae9742bf",
"assets/assets/layouts/dragon.layout": "c31d21533fca937d86a6ade7ee8f2e16",
"assets/assets/layouts/eagle.desktop": "6521d540b08b7a46c521e5d2e18aa3e0",
"assets/assets/layouts/eagle.layout": "efeb7a811e9a3d5d8c0f70575e8b3aa3",
"assets/assets/layouts/enterprise.desktop": "486f24de6aaafe4848f39f2faa62c5eb",
"assets/assets/layouts/enterprise.layout": "9b0b1114667297632ede8f423c0027e2",
"assets/assets/layouts/explosion.desktop": "917577091eb119554c28514f476d0088",
"assets/assets/layouts/explosion.layout": "3eb59b43c15a3ca1a872989efa37705c",
"assets/assets/layouts/flowers.desktop": "45d551beac9a3d317b4f09a11d2248c4",
"assets/assets/layouts/flowers.layout": "f100d601cae8d5497e6c1b3c2d4aa98a",
"assets/assets/layouts/future.desktop": "17037e65416dd21be7be9e1c2e170846",
"assets/assets/layouts/future.layout": "e0d2bbfcd3e8cf487f17e99482c8b3bb",
"assets/assets/layouts/galaxy.desktop": "187fde3a93f51d7abe8f431fff7a65ed",
"assets/assets/layouts/galaxy.layout": "35a9119cb9dfd42774d790b50508b452",
"assets/assets/layouts/garden.desktop": "922f65be3133f720434ef8036d24105e",
"assets/assets/layouts/garden.layout": "551561377d48127eba31935f8c4c423f",
"assets/assets/layouts/girl.desktop": "7bcc32be29fbfa5d017b3e0543848cac",
"assets/assets/layouts/girl.layout": "98ab008c244dd25c0ca19b633b648a8b",
"assets/assets/layouts/glade.desktop": "80b889d1820f8b8b4f9dcb5c6eab4d58",
"assets/assets/layouts/glade.layout": "f4a8728a5f5735e4a67d5b50a4e0a144",
"assets/assets/layouts/grid.desktop": "27d315c923515da73a1258149db27d0d",
"assets/assets/layouts/grid.layout": "49626a99385628f5bd595fdffb7b0bc5",
"assets/assets/layouts/helios.desktop": "e10f3817ab9075a2a7057bacd115866c",
"assets/assets/layouts/helios.layout": "98b4b89a2a3048a8fbc53beaeee3a8ba",
"assets/assets/layouts/hole.desktop": "6bfa5dbe2132fb95c691d44c0d164140",
"assets/assets/layouts/hole.layout": "32f588885ce5aebea050e822eeff5263",
"assets/assets/layouts/inner_circle.desktop": "b57667be10f0b3502fb137f1fc6a2d1c",
"assets/assets/layouts/inner_circle.layout": "ab1d1f1ca62ad01cb6951f062e36c360",
"assets/assets/layouts/key.desktop": "715460f474ca26fc911c9873985c3e1d",
"assets/assets/layouts/key.layout": "8c38b0283056930008ae0839b187edf1",
"assets/assets/layouts/km.desktop": "1027b1e803218a8bcd6c1461aec3bfa7",
"assets/assets/layouts/km.layout": "0c8b6225ac1bec4678d445e7cb32a8a1",
"assets/assets/layouts/labyrinth.desktop": "57fc60c528f4bbba733508196d6d9159",
"assets/assets/layouts/labyrinth.layout": "cfc99e7f31ede92a6ac54dea65c4ebd7",
"assets/assets/layouts/mask.desktop": "07ab2105c6bdab210b5e4bbaf4903058",
"assets/assets/layouts/mask.layout": "490b4df062b7f2b02378c42eb9ed28b0",
"assets/assets/layouts/maya.desktop": "5a74c06a5a8492b96fcc236902f0ea22",
"assets/assets/layouts/maya.layout": "d296212cd1f473b726c946e844eb8f9d",
"assets/assets/layouts/maze.desktop": "511baa8949857c069beb36831efd79bc",
"assets/assets/layouts/maze.layout": "0d11c6af7e6df0111b6d4849dbad362e",
"assets/assets/layouts/mesh.desktop": "90e7524875861261886d69a8fb2fabb7",
"assets/assets/layouts/mesh.layout": "fb683a1bf9ca0c9667b509675187965d",
"assets/assets/layouts/moth.desktop": "d4f0a2361b12c66bdb02a7743b056451",
"assets/assets/layouts/moth.layout": "ba19ef9d029a413bae14f705ba96ae21",
"assets/assets/layouts/order.desktop": "4a061c161967f0625c11a7d8ab004aac",
"assets/assets/layouts/order.layout": "679270089957d95352b72c7cf63e951f",
"assets/assets/layouts/pattern.desktop": "fb1d35df605d26b020a1d0b68036c1d9",
"assets/assets/layouts/pattern.layout": "3ad75d605db86ac3f613d43d7d86002c",
"assets/assets/layouts/penta.desktop": "ea54de620db2d5dc58137c0ae80127fa",
"assets/assets/layouts/penta.layout": "89fbd8a2175647e737804c0c3681c2d2",
"assets/assets/layouts/pillars.desktop": "81e5417d749b333912f5ab0c1433e507",
"assets/assets/layouts/pillars.layout": "181ac9723cb42f57b2332e405e985b53",
"assets/assets/layouts/pirates.desktop": "e28cd93089ddc681917930613b009a9e",
"assets/assets/layouts/pirates.layout": "fd1db1784fccb7c26f2d23f1468023b2",
"assets/assets/layouts/pyramid.desktop": "18a2b3ecbfc2b0477fac71b41df8a897",
"assets/assets/layouts/pyramid.layout": "750a12d7c47865e692412f4c433e15da",
"assets/assets/layouts/rocket.desktop": "4df4349724c0e59c4f149aecb2de35d7",
"assets/assets/layouts/rocket.layout": "0821498f203c347dd7075f9cd1a4c4cd",
"assets/assets/layouts/shield.desktop": "c0a8a99ce6f22cce2a345f5dc874215b",
"assets/assets/layouts/shield.layout": "1f3acebb4647c44ff00814ec59092736",
"assets/assets/layouts/spider.desktop": "01c4468ece160ae87dc25a657dbe0edb",
"assets/assets/layouts/spider.layout": "bcb7fe86873f79df805021fcace02189",
"assets/assets/layouts/squares.desktop": "2323f8023178ebd1e62823a2035a211a",
"assets/assets/layouts/squares.layout": "6f4b03cf8d2e21e79b2273c3b46d6b1a",
"assets/assets/layouts/squaring.desktop": "6778dd973e49d7647413846539760908",
"assets/assets/layouts/squaring.layout": "3fdacf6d46ea6c4ae0b2022743a7025c",
"assets/assets/layouts/stadion.desktop": "5e2bb4d1ab1ba49249f642544e903827",
"assets/assets/layouts/stadion.layout": "7d886f21cf1fdb3c8cdcd93e742e89cb",
"assets/assets/layouts/stairs.desktop": "7dd783910b3ef6b12a5a798630a7d4e1",
"assets/assets/layouts/stairs.layout": "1653661be25e9d3e74f92ad41929c216",
"assets/assets/layouts/star.desktop": "ce2596aade49c21ff47925524688e4f2",
"assets/assets/layouts/star.layout": "6bad9a18e529e6b767bb7e21655a49c7",
"assets/assets/layouts/star_ship.desktop": "e708bda4f6145d87ffd491e9f1e7ae66",
"assets/assets/layouts/star_ship.layout": "4dcea3e2a4591a315480b0a7cf3ee29b",
"assets/assets/layouts/stax.desktop": "29c9f24cebae229d8f8cf1226b8750b3",
"assets/assets/layouts/stax.layout": "1449ba667b1e6ebe53637c341ae30df2",
"assets/assets/layouts/swirl.desktop": "4569258b9f907c830ff50b572feb7faa",
"assets/assets/layouts/swirl.layout": "225886a66296698ba35498f724dddff4",
"assets/assets/layouts/temple.desktop": "218f211f7bfbc048f84e76124b9437ae",
"assets/assets/layouts/temple.layout": "83097725bc574bf64d9ec9aad4419e88",
"assets/assets/layouts/theatre.desktop": "bc851e9135af3aca40783ccadbf02962",
"assets/assets/layouts/theatre.layout": "066798d5efb4857dc2196dec9f1c97b3",
"assets/assets/layouts/the_door.desktop": "40f3be3b2840fc6f93492dbf5311a40b",
"assets/assets/layouts/the_door.layout": "8e2923b26658457362d523eed5a189e1",
"assets/assets/layouts/time_tunnel.desktop": "dfd6d88eaa8a9daae166479271b7877f",
"assets/assets/layouts/time_tunnel.layout": "0523dc5d17b100a2eef6b924280d605b",
"assets/assets/layouts/tomb.desktop": "f7fa5145bd33153d52687d87ba352dd6",
"assets/assets/layouts/tomb.layout": "942f1c59a8e18036d10566c4d3547731",
"assets/assets/layouts/totem.desktop": "0ccdfd32a7aaa57c02545edc0944afab",
"assets/assets/layouts/totem.layout": "cc5cb3b4a13ccab5ab5f61094bc314cb",
"assets/assets/layouts/tower.desktop": "ab0301d763bbd912f7f06fb3fa3c9f7d",
"assets/assets/layouts/tower.layout": "be5b2bc110ae83580b042bf7366a85bf",
"assets/assets/layouts/triangle.desktop": "6ff484bfafc751a091cbf21e6ef88731",
"assets/assets/layouts/triangle.layout": "eeec555fa7442e1dfc93acba260558c5",
"assets/assets/layouts/up&down.desktop": "a4cd5bb5d012e511bf05a6eaddb2066b",
"assets/assets/layouts/up&down.layout": "e3c1645b19038f95c194670e0d176228",
"assets/assets/layouts/Vi.desktop": "77899a41da865c473f099bf3507f372d",
"assets/assets/layouts/Vi.layout": "39c7616d50d334a5076a0821eb4edbc0",
"assets/assets/layouts/well.desktop": "cbd1874840ffdf7dd98a6163dfdee998",
"assets/assets/layouts/well.layout": "d75814dcac82a72fb8ddf2a7657dcd02",
"assets/assets/layouts/X_shaped.desktop": "991153e6c485ac52277895decf55a1c4",
"assets/assets/layouts/X_shaped.layout": "59de914d7ebd6fdee049aaf6b9aad725",
"assets/assets/tilesets/alphabet/BAMBOO_1.png": "7b1feeb7577cdcd023d225b1a08159c8",
"assets/assets/tilesets/alphabet/BAMBOO_2.png": "f9ddca2d490ff1c7daa4731ddd420a3c",
"assets/assets/tilesets/alphabet/BAMBOO_3.png": "90b2a2b9ebc954b870e625293f4467ae",
"assets/assets/tilesets/alphabet/BAMBOO_4.png": "f9feb25b526fed757887d3abf7773b2e",
"assets/assets/tilesets/alphabet/BAMBOO_5.png": "15e168e00e74cb71422a81607f2c2fd4",
"assets/assets/tilesets/alphabet/BAMBOO_6.png": "33eea032fe198cf999c06942b30294a9",
"assets/assets/tilesets/alphabet/BAMBOO_7.png": "fecfdb2cc582efecd008155d16748cef",
"assets/assets/tilesets/alphabet/BAMBOO_8.png": "2763b3b96b571a36b77a9d390f3985da",
"assets/assets/tilesets/alphabet/BAMBOO_9.png": "29a4590bdaff18ced14f384e8fc26008",
"assets/assets/tilesets/alphabet/CHARACTER_1.png": "701b2d8369ee55ce9d8c3f76181ab67b",
"assets/assets/tilesets/alphabet/CHARACTER_2.png": "f34690f4be8206e639d401301210174e",
"assets/assets/tilesets/alphabet/CHARACTER_3.png": "83435e7dbe190047ebf34c389aa6eb70",
"assets/assets/tilesets/alphabet/CHARACTER_4.png": "a4c2110f21add7cec54aee0b5482a61d",
"assets/assets/tilesets/alphabet/CHARACTER_5.png": "161a697a3711cbd14acb4d3292640f7c",
"assets/assets/tilesets/alphabet/CHARACTER_6.png": "bc034f154eb8c12c2aa3057147633ba7",
"assets/assets/tilesets/alphabet/CHARACTER_7.png": "e2579b008657eaab1fa0dfc0068d6254",
"assets/assets/tilesets/alphabet/CHARACTER_8.png": "22cd363523117b3e16380f4894003319",
"assets/assets/tilesets/alphabet/CHARACTER_9.png": "a1b46cd29ab1a7f20cbc6510c3543de3",
"assets/assets/tilesets/alphabet/DRAGON_1.png": "4f3fb6f2c13fc0e86322d672514c6974",
"assets/assets/tilesets/alphabet/DRAGON_2.png": "ceb2ec1487396a2c8c96dd9cc1409b2d",
"assets/assets/tilesets/alphabet/DRAGON_3.png": "6900830610f5eb7681af783e2d29d5d7",
"assets/assets/tilesets/alphabet/FLOWER_1.png": "952cfe29a86e0886f622ba0437e58e39",
"assets/assets/tilesets/alphabet/FLOWER_2.png": "952cfe29a86e0886f622ba0437e58e39",
"assets/assets/tilesets/alphabet/FLOWER_3.png": "952cfe29a86e0886f622ba0437e58e39",
"assets/assets/tilesets/alphabet/FLOWER_4.png": "952cfe29a86e0886f622ba0437e58e39",
"assets/assets/tilesets/alphabet/ROD_1.png": "690f2f93e66d3a76ee09a43e1b9484ec",
"assets/assets/tilesets/alphabet/ROD_2.png": "ec3ea4479a531be475985e28c95f35e6",
"assets/assets/tilesets/alphabet/ROD_3.png": "8e5ff8e5239250a8a1af7f45923b59c8",
"assets/assets/tilesets/alphabet/ROD_4.png": "279cdda6676fe17c32590ba2e9e2f1ec",
"assets/assets/tilesets/alphabet/ROD_5.png": "3801849c1156ed761ebb238640bfb1b9",
"assets/assets/tilesets/alphabet/ROD_6.png": "498ffcc530ca5fe4e39806bba24c2357",
"assets/assets/tilesets/alphabet/ROD_7.png": "18d6d5ccf92985706a3181a9a2c77dab",
"assets/assets/tilesets/alphabet/ROD_8.png": "5c606958e97d552f40442a5fa41c65ca",
"assets/assets/tilesets/alphabet/ROD_9.png": "1977b0ed4ed1df8586cf57287b9d2c1c",
"assets/assets/tilesets/alphabet/SEASON_1.png": "7715b5d8d26949c84ace5be71b7c0425",
"assets/assets/tilesets/alphabet/SEASON_2.png": "7715b5d8d26949c84ace5be71b7c0425",
"assets/assets/tilesets/alphabet/SEASON_3.png": "a68381c4853e42e32ac255f1c51930be",
"assets/assets/tilesets/alphabet/SEASON_4.png": "a68381c4853e42e32ac255f1c51930be",
"assets/assets/tilesets/alphabet/TILE_1.png": "e403901430e8a8b2c88af7de1b434fd3",
"assets/assets/tilesets/alphabet/TILE_1_SEL.png": "a4f4b4566b9803ee0a7e55334812ce38",
"assets/assets/tilesets/alphabet/WIND_1.png": "d33d1c6b10952e9dbf591963df9f413c",
"assets/assets/tilesets/alphabet/WIND_2.png": "805263c926ec434f8b98b980a6761e14",
"assets/assets/tilesets/alphabet/WIND_3.png": "8de46a5a2d121b44cad73a3672018a08",
"assets/assets/tilesets/alphabet/WIND_4.png": "0275bdcbc5edecfd0f05bb9233d8ec9f",
"assets/assets/tilesets/alphabet.copyright": "f9b46acf991aa312bcdcd95873e9dcc5",
"assets/assets/tilesets/alphabet.desktop": "6552182b8e6512a0edeeba561087a051",
"assets/assets/tilesets/alphabet.svg": "f99b9c3ffe1d3018b66cd3d7f1cf254d",
"assets/assets/tilesets/bamboo/BAMBOO_1.png": "3b111dba57a47936122ee394b809a3b1",
"assets/assets/tilesets/bamboo/BAMBOO_2.png": "e9972109225fe7c016aa52c5a342fbcb",
"assets/assets/tilesets/bamboo/BAMBOO_3.png": "d47aaff8ec5995cfd6109d062163a314",
"assets/assets/tilesets/bamboo/BAMBOO_4.png": "59939ff495299b9215f2f38403913635",
"assets/assets/tilesets/bamboo/BAMBOO_5.png": "e458998a1026dd900fabffa895c80063",
"assets/assets/tilesets/bamboo/BAMBOO_6.png": "2e70d91060d66a7225259a49d66d9cc2",
"assets/assets/tilesets/bamboo/BAMBOO_7.png": "2fdf93eb49f3d37a92e71474cba81dfd",
"assets/assets/tilesets/bamboo/BAMBOO_8.png": "ee677714b0e5dfb716ba20a68941b9c2",
"assets/assets/tilesets/bamboo/BAMBOO_9.png": "b1bad0ea228c96405a1f72cc0622efbc",
"assets/assets/tilesets/bamboo/CHARACTER_1.png": "e24095b53fd82a441348deced931dfbd",
"assets/assets/tilesets/bamboo/CHARACTER_2.png": "2ca7cde1727c46f0d7572291b2fa7391",
"assets/assets/tilesets/bamboo/CHARACTER_3.png": "aa602d9ae49920d38b9f38e8f17887aa",
"assets/assets/tilesets/bamboo/CHARACTER_4.png": "167f6cb2f7051c52c38c2886223d8a54",
"assets/assets/tilesets/bamboo/CHARACTER_5.png": "faafd27287a80500a79ae8424622fe51",
"assets/assets/tilesets/bamboo/CHARACTER_6.png": "7e83a148fa95e9fb77645401abae8678",
"assets/assets/tilesets/bamboo/CHARACTER_7.png": "53c54a02f0516095c336c6159e5485df",
"assets/assets/tilesets/bamboo/CHARACTER_8.png": "b6ae372edbdf8563824c6b82ea3fdd9a",
"assets/assets/tilesets/bamboo/CHARACTER_9.png": "03a3495c0b3b5cad3f01eb7d1d0e1bc4",
"assets/assets/tilesets/bamboo/DRAGON_1.png": "c4fddd8e81c697b096d91b439deae4b4",
"assets/assets/tilesets/bamboo/DRAGON_2.png": "9c9ffa586a109639125cc3bf186dd3b6",
"assets/assets/tilesets/bamboo/DRAGON_3.png": "93e8da1e69dac0c1d6af892ac12c35e6",
"assets/assets/tilesets/bamboo/FLOWER_1.png": "b3a88190b0e3caf87b7ff78a10d4e0e0",
"assets/assets/tilesets/bamboo/FLOWER_2.png": "759a0e437d38cb3eef210a3e2e54c5fe",
"assets/assets/tilesets/bamboo/FLOWER_3.png": "041548c6bd5a7879640e6c44b7f82087",
"assets/assets/tilesets/bamboo/FLOWER_4.png": "90e6be385b0cdfd76d2c440dbda26318",
"assets/assets/tilesets/bamboo/ROD_1.png": "1e40da53f85268d5c43fcadbc08b52a5",
"assets/assets/tilesets/bamboo/ROD_2.png": "109650d43c8c0ffc2f65a8fabc0e46c8",
"assets/assets/tilesets/bamboo/ROD_3.png": "a386cef380078050f4b76cb2fe0df2c7",
"assets/assets/tilesets/bamboo/ROD_4.png": "c33de19927ea660efeb8263a3865e6e4",
"assets/assets/tilesets/bamboo/ROD_5.png": "c7185a1da555a6e7110e1e644ef13bf1",
"assets/assets/tilesets/bamboo/ROD_6.png": "23a12c64026c52993123dacc5bb36fb0",
"assets/assets/tilesets/bamboo/ROD_7.png": "9d09c22dea4f178b7b4351019016233e",
"assets/assets/tilesets/bamboo/ROD_8.png": "20884e67c6d4a8236feae63a44fd8f81",
"assets/assets/tilesets/bamboo/ROD_9.png": "af5b886c71ef6aa6294f3c5cd0e7d5a1",
"assets/assets/tilesets/bamboo/SEASON_1.png": "b0a599c9c5df4812bd04b8e631e9ede5",
"assets/assets/tilesets/bamboo/SEASON_2.png": "c5eee8aa99459e428d4b94415ddd9f5a",
"assets/assets/tilesets/bamboo/SEASON_3.png": "192869f6877ea8053acce5f237455945",
"assets/assets/tilesets/bamboo/SEASON_4.png": "cbaf963ad7c8f153e301259ed8564ef7",
"assets/assets/tilesets/bamboo/TILE_1.png": "818d0f3483cf2e11158669ecf2f6edea",
"assets/assets/tilesets/bamboo/TILE_1_SEL.png": "8fde34f41bc3c3235bde1a6e10102de8",
"assets/assets/tilesets/bamboo/WIND_1.png": "84397a218b7dff9bc895f61f7d87ddfa",
"assets/assets/tilesets/bamboo/WIND_2.png": "1b43d6c3589bf09d57653d8ccda59d0c",
"assets/assets/tilesets/bamboo/WIND_3.png": "0ace703883a0e9ab3cd95b8b85cdb447",
"assets/assets/tilesets/bamboo/WIND_4.png": "2bc7beb658253ed4d22fe8137dc59005",
"assets/assets/tilesets/bamboo.copyright": "9f20df076f27e849dbb45f50de4d6d53",
"assets/assets/tilesets/bamboo.desktop": "04c525d13b4f89e22c5eac6eb748f653",
"assets/assets/tilesets/bamboo.svg": "8c006afc63ed3ff51fa3d2311c5735e8",
"assets/assets/tilesets/classic/BAMBOO_1.png": "2d9733b3d407c846eaf95d5ae1e9c3ab",
"assets/assets/tilesets/classic/BAMBOO_2.png": "e324d8ed5fa817a81f4ed65db17c9961",
"assets/assets/tilesets/classic/BAMBOO_3.png": "28cbf426a98c5ce2f763f222325c0f31",
"assets/assets/tilesets/classic/BAMBOO_4.png": "6f69f705b45e5106bf53e735c654b317",
"assets/assets/tilesets/classic/BAMBOO_5.png": "7763cd4b141d1e792051038772287586",
"assets/assets/tilesets/classic/BAMBOO_6.png": "d9207eb5658b34b42486eec69a7b4b23",
"assets/assets/tilesets/classic/BAMBOO_7.png": "ac37177912cca3da03d44544bbed45c2",
"assets/assets/tilesets/classic/BAMBOO_8.png": "9f29db0e73d259ae346dc7c7ecdfb593",
"assets/assets/tilesets/classic/BAMBOO_9.png": "8b09aa0f2a5a2afe02feb2dedd129c07",
"assets/assets/tilesets/classic/CHARACTER_1.png": "b2c75ed2505a624a49d365b065238d0d",
"assets/assets/tilesets/classic/CHARACTER_2.png": "ca9c30d5d3ddc5be77b7151e1cb2d314",
"assets/assets/tilesets/classic/CHARACTER_3.png": "5a84b7a8c2d83caa877c7efb660ee0ba",
"assets/assets/tilesets/classic/CHARACTER_4.png": "a54f4000999ed79daf168577580f8288",
"assets/assets/tilesets/classic/CHARACTER_5.png": "70b0b38180f8bf28eaff38a45cd859c0",
"assets/assets/tilesets/classic/CHARACTER_6.png": "2d6bdec62746658e145f1fbfe298c13e",
"assets/assets/tilesets/classic/CHARACTER_7.png": "16221af0a4bffb8faa90252d94710dbf",
"assets/assets/tilesets/classic/CHARACTER_8.png": "8b02c63965888c13638589b94d1de8fd",
"assets/assets/tilesets/classic/CHARACTER_9.png": "9b9995fed9ed278eaacd05210e79142c",
"assets/assets/tilesets/classic/DRAGON_1.png": "66e9479e6a796cfa3a48ecbb364d8be5",
"assets/assets/tilesets/classic/DRAGON_2.png": "33cbae9beac7ae97d900fac630c90d87",
"assets/assets/tilesets/classic/DRAGON_3.png": "1db226a8b210fd08301eab63a75ea737",
"assets/assets/tilesets/classic/FLOWER_1.png": "11cc7d165f0796bd8f2c9fea97a29064",
"assets/assets/tilesets/classic/FLOWER_2.png": "c2c1f182ef78c0d0aaf7a31933e084da",
"assets/assets/tilesets/classic/FLOWER_3.png": "60b52bcf67c7b380d737d0442848295a",
"assets/assets/tilesets/classic/FLOWER_4.png": "b8bcc66d0d42f24f1546d95af8e2f8c5",
"assets/assets/tilesets/classic/ROD_1.png": "1a692f3663bb09dcd373d662bdfc8197",
"assets/assets/tilesets/classic/ROD_2.png": "2062cba825fbe55f3396280a9e2265a0",
"assets/assets/tilesets/classic/ROD_3.png": "bf31327e6d05bffc4c5bfe7ce316ce38",
"assets/assets/tilesets/classic/ROD_4.png": "31cd56d9147f01bf5f5671a356dd8bd8",
"assets/assets/tilesets/classic/ROD_5.png": "b7b7694d5d1273848db113cba341cc68",
"assets/assets/tilesets/classic/ROD_6.png": "83eed80a4323587646340554f641ae23",
"assets/assets/tilesets/classic/ROD_7.png": "9db4f66117512a696b1294f7473893a3",
"assets/assets/tilesets/classic/ROD_8.png": "3974c0b9d5a6fd77165f27bf5f45c574",
"assets/assets/tilesets/classic/ROD_9.png": "2b4ecfe37de456fa6d6a4c073a02df39",
"assets/assets/tilesets/classic/SEASON_1.png": "2e3c575ff39adc775f5ed80d573466b5",
"assets/assets/tilesets/classic/SEASON_2.png": "eed4ac39c99d9e6083393e6fab825dc8",
"assets/assets/tilesets/classic/SEASON_3.png": "a4fbdf04cc6df57ca1c934ee5d53ad72",
"assets/assets/tilesets/classic/SEASON_4.png": "be097cd6302f3400237f071a2129d438",
"assets/assets/tilesets/classic/TILE_1.png": "c2d23bd2fcfd09407e29be826974a44a",
"assets/assets/tilesets/classic/TILE_1_SEL.png": "fd36b76048500d21223ba3f1cab3993b",
"assets/assets/tilesets/classic/WIND_1.png": "f182bc94788ff3372e862826f6448d48",
"assets/assets/tilesets/classic/WIND_2.png": "393843abf7c54851f4bac42b53065030",
"assets/assets/tilesets/classic/WIND_3.png": "821f2d0dd36ec38c115425d53866748c",
"assets/assets/tilesets/classic/WIND_4.png": "ae7f3d9731e17590a64a27c7feeb2e87",
"assets/assets/tilesets/classic.copyright": "4797540636de14228e3101ee817508c1",
"assets/assets/tilesets/classic.desktop": "fa09c17ba4df497ddc68d27b657c0f52",
"assets/assets/tilesets/classic.svg": "19bac33701167446a6a44a40de70e1f1",
"assets/assets/tilesets/default/BAMBOO_1.png": "ea05a7943c4709b5ddfe3238dfba4ac6",
"assets/assets/tilesets/default/BAMBOO_2.png": "9963a31c6e92d42531681b0eb3b2c561",
"assets/assets/tilesets/default/BAMBOO_3.png": "4ec7b0da7bd0d2e3f7eb39f783734f9e",
"assets/assets/tilesets/default/BAMBOO_4.png": "82459f35cc72f37c365874bfc060ca15",
"assets/assets/tilesets/default/BAMBOO_5.png": "a6d39c866b6f1b573b563d5742ba5d7f",
"assets/assets/tilesets/default/BAMBOO_6.png": "e6babd44fa514c85b0cd3f073cda23ea",
"assets/assets/tilesets/default/BAMBOO_7.png": "825c3301876600d9f565f026ce5c6816",
"assets/assets/tilesets/default/BAMBOO_8.png": "2570d7d02773c2fc74fba55c3c73906b",
"assets/assets/tilesets/default/BAMBOO_9.png": "6714077e250d24d06ea3f9e7acb00568",
"assets/assets/tilesets/default/CHARACTER_1.png": "300a023f5b18287c46404daa130f1179",
"assets/assets/tilesets/default/CHARACTER_2.png": "5200601489f3c803f97cc345ef27b29a",
"assets/assets/tilesets/default/CHARACTER_3.png": "b5374da73ae2ec8126c9b3e61f52983e",
"assets/assets/tilesets/default/CHARACTER_4.png": "580ff4ee22ead07d24886297b68e898f",
"assets/assets/tilesets/default/CHARACTER_5.png": "6e2c9c19da313d2ad3e20570a50e83ed",
"assets/assets/tilesets/default/CHARACTER_6.png": "ec71242c20b49f1a8d86bb17290e02fa",
"assets/assets/tilesets/default/CHARACTER_7.png": "9220bff6d6d83c52c2c9197bb4818051",
"assets/assets/tilesets/default/CHARACTER_8.png": "7c7a83dbc907a92e87aa99f38f2ceab6",
"assets/assets/tilesets/default/CHARACTER_9.png": "da2e4cab645c438a5a6ebfbd797df4cf",
"assets/assets/tilesets/default/DRAGON_1.png": "4095ff1b4eddd0ef8bb9647d6836d58f",
"assets/assets/tilesets/default/DRAGON_2.png": "8627b4563e4eef5fa3bd6b8dcb9ae6a2",
"assets/assets/tilesets/default/DRAGON_3.png": "386510c9a1601ff1c3354786d2126988",
"assets/assets/tilesets/default/FLOWER_1.png": "b91d54dc008ffc47e95d963cc7cfc592",
"assets/assets/tilesets/default/FLOWER_2.png": "74b0c21b441e2bc7c20113bef186e5ae",
"assets/assets/tilesets/default/FLOWER_3.png": "9188a30c65793d99cef642813635059a",
"assets/assets/tilesets/default/FLOWER_4.png": "6e9c4984eb05d9e37ff04671ac6ed8cd",
"assets/assets/tilesets/default/ROD_1.png": "1a343830a7cbf508c89811141270fbfd",
"assets/assets/tilesets/default/ROD_2.png": "76098425962c6af8751d513ef964c2ab",
"assets/assets/tilesets/default/ROD_3.png": "9233dea45ceb99ded2011846e8197fdc",
"assets/assets/tilesets/default/ROD_4.png": "dfbfba8637c93212913a0a7daf6c4300",
"assets/assets/tilesets/default/ROD_5.png": "3b7dbbe75b11409be165df1c3491ff2a",
"assets/assets/tilesets/default/ROD_6.png": "7d6a256302030d72dd0582fe03e28609",
"assets/assets/tilesets/default/ROD_7.png": "bcd15418421b09a3a83acdc24222c00f",
"assets/assets/tilesets/default/ROD_8.png": "f0d5460886c5efe6fff16e54f1a1eabd",
"assets/assets/tilesets/default/ROD_9.png": "aea850ffb5d079d35a061e36b33f7f41",
"assets/assets/tilesets/default/SEASON_1.png": "477e9797a597b4fee51999015a1495fc",
"assets/assets/tilesets/default/SEASON_2.png": "c3c091e15241e3b3558dbbd1acdf94ff",
"assets/assets/tilesets/default/SEASON_3.png": "0da09cceea729f9b321ed18b2db1a53a",
"assets/assets/tilesets/default/SEASON_4.png": "00c3e6b6de541590c85313274c24d59d",
"assets/assets/tilesets/default/TILE_1.png": "69247577f1563399a517d10519474f05",
"assets/assets/tilesets/default/TILE_1_SEL.png": "337894c15a250f754905cc9d619aa41e",
"assets/assets/tilesets/default/WIND_1.png": "c66f191f9ac7dca7f4a73f0934d5aec1",
"assets/assets/tilesets/default/WIND_2.png": "0e63d431d433acd4a236e45785aa8b2f",
"assets/assets/tilesets/default/WIND_3.png": "ac401257af2466e390dbdf3957e47679",
"assets/assets/tilesets/default/WIND_4.png": "1a4718bf22e28adf60f9794eb64d6b29",
"assets/assets/tilesets/default.copyright": "ca9ec08e0694252620dc20b4cc7f3b75",
"assets/assets/tilesets/default.desktop": "a602b7a1de1eb7756730ea642e907585",
"assets/assets/tilesets/default.svg": "a50ff8e46f66234fc5f30ed3207b6870",
"assets/assets/tilesets/egypt/BAMBOO_1.png": "3ac1c493c7eb7b62208cdd35dbb17d94",
"assets/assets/tilesets/egypt/BAMBOO_2.png": "a266aacde444a9f744929c85d609390c",
"assets/assets/tilesets/egypt/BAMBOO_3.png": "83652c51a882807274b2f67b326f2105",
"assets/assets/tilesets/egypt/BAMBOO_4.png": "8f8418f8ba923c375828178031d0fad4",
"assets/assets/tilesets/egypt/BAMBOO_5.png": "130433433ba1cf0bc1a715481ec713f2",
"assets/assets/tilesets/egypt/BAMBOO_6.png": "4ae9b18d540334df4dc78d38c3a6c0c8",
"assets/assets/tilesets/egypt/BAMBOO_7.png": "a7a912fe55961f2f5320202a46c959b6",
"assets/assets/tilesets/egypt/BAMBOO_8.png": "87d9c389bd2e4837ddab86f8858fe4c9",
"assets/assets/tilesets/egypt/BAMBOO_9.png": "5ee0e8beadd1e34d27ab746556ae75d2",
"assets/assets/tilesets/egypt/CHARACTER_1.png": "60c703a37c36af79ce76b493a2d01f9f",
"assets/assets/tilesets/egypt/CHARACTER_2.png": "8047b1806af679eca5836af9e327655a",
"assets/assets/tilesets/egypt/CHARACTER_3.png": "34108e09139695a12049c1bff254e6ae",
"assets/assets/tilesets/egypt/CHARACTER_4.png": "759c478b4aa179588e076f13b4fd6fad",
"assets/assets/tilesets/egypt/CHARACTER_5.png": "2720b19f0adeab934703dc0488699cf5",
"assets/assets/tilesets/egypt/CHARACTER_6.png": "77daaad8db1ebaac0978fdb011ad0ca6",
"assets/assets/tilesets/egypt/CHARACTER_7.png": "80b923c3dcf40f4ff96f7d5248049133",
"assets/assets/tilesets/egypt/CHARACTER_8.png": "3915d28ee16abc2b8fe6ec2804af150c",
"assets/assets/tilesets/egypt/CHARACTER_9.png": "af3cf5f6477191fcc211114cc078bf2b",
"assets/assets/tilesets/egypt/DRAGON_1.png": "ad7e895a8e7547aa2401a8efbccdbcb4",
"assets/assets/tilesets/egypt/DRAGON_2.png": "81d7b3c9983ad445395a197edfc9e63e",
"assets/assets/tilesets/egypt/DRAGON_3.png": "b6bc0a383c6a80b7711a1cee219db96b",
"assets/assets/tilesets/egypt/FLOWER_1.png": "c525f1130638476165b1677e7a859b23",
"assets/assets/tilesets/egypt/FLOWER_2.png": "837de9b3f383929df61a321a52fc12cd",
"assets/assets/tilesets/egypt/FLOWER_3.png": "b187174dd7ca7a71e1c86ada5a6175c4",
"assets/assets/tilesets/egypt/FLOWER_4.png": "b836f2e1b636e6180c052c4dc5f18a07",
"assets/assets/tilesets/egypt/ROD_1.png": "ea0cbdf20289a1224b11a75de1f5c9e5",
"assets/assets/tilesets/egypt/ROD_2.png": "b680d591e76fdb88d5e1f31a6e6c5f5b",
"assets/assets/tilesets/egypt/ROD_3.png": "a40e958e82ca97aa463bce8694f771ba",
"assets/assets/tilesets/egypt/ROD_4.png": "90ecb99fbfa734bb94b4aba3a6112bdf",
"assets/assets/tilesets/egypt/ROD_5.png": "d16aa6d0810b0856a14cee32fd5d7240",
"assets/assets/tilesets/egypt/ROD_6.png": "555476596a4c726ab02c6fce8f66966d",
"assets/assets/tilesets/egypt/ROD_7.png": "361cb0b4230f0ebc78c5f326c930c83c",
"assets/assets/tilesets/egypt/ROD_8.png": "4bddd6f33a73aaecdc634d7196a2ee3a",
"assets/assets/tilesets/egypt/ROD_9.png": "bbe722cf9d05ac3abff18fb154645235",
"assets/assets/tilesets/egypt/SEASON_1.png": "ca5a4c543dc874293b2f6768f72feef4",
"assets/assets/tilesets/egypt/SEASON_2.png": "041044c82257a4595d02c3052dd7972a",
"assets/assets/tilesets/egypt/SEASON_3.png": "8e4aae39d69dea0804b68bcb73ad59bd",
"assets/assets/tilesets/egypt/SEASON_4.png": "ae92fe5b078dd466841c647a558f2281",
"assets/assets/tilesets/egypt/TILE_1.png": "0e7388d5a19243e152e624b4b6e7e833",
"assets/assets/tilesets/egypt/TILE_1_SEL.png": "ea6d436c67b4a1d2c0a8c713f8a6f801",
"assets/assets/tilesets/egypt/WIND_1.png": "8c071296e59804513a8a1e22f0404075",
"assets/assets/tilesets/egypt/WIND_2.png": "65eb0f3f57698c74969603d093ebf0b4",
"assets/assets/tilesets/egypt/WIND_3.png": "94fdfdbca38741d308569d1ebb23c06b",
"assets/assets/tilesets/egypt/WIND_4.png": "7364b56ee9a5c28f8e93b332643829a8",
"assets/assets/tilesets/egypt.copyright": "9fb8f72d0b9835f35e0e2f8f30bcaa5c",
"assets/assets/tilesets/egypt.desktop": "7e3bbfb9c83aee80001af1d09462af6d",
"assets/assets/tilesets/egypt.svg": "880be81517a816e0c6f8d7000a92a0c5",
"assets/assets/tilesets/jade/BAMBOO_1.png": "f3aa803522427cd93c4c26837132f63a",
"assets/assets/tilesets/jade/BAMBOO_2.png": "4500f253575e3b2bbfd3f5d1fae68b8d",
"assets/assets/tilesets/jade/BAMBOO_3.png": "2f55b6c671b2f6421a7bf49eb252544d",
"assets/assets/tilesets/jade/BAMBOO_4.png": "619ca38fb3782f3b1b379244c5176d18",
"assets/assets/tilesets/jade/BAMBOO_5.png": "dd171fe280e971731c714047b8fb46c5",
"assets/assets/tilesets/jade/BAMBOO_6.png": "85b938a980d9166207668f0fabe17c34",
"assets/assets/tilesets/jade/BAMBOO_7.png": "bb8aa78602d4edd9c121f5e84cb908aa",
"assets/assets/tilesets/jade/BAMBOO_8.png": "18b51688d03c40441a1419db727c41be",
"assets/assets/tilesets/jade/BAMBOO_9.png": "99915a76b09de543d6f4cd48be87fbc4",
"assets/assets/tilesets/jade/CHARACTER_1.png": "c125e52c1abe59ebb60260a5e3c69d36",
"assets/assets/tilesets/jade/CHARACTER_2.png": "b93c04331b85653066363fa61c439719",
"assets/assets/tilesets/jade/CHARACTER_3.png": "613ecb22e6919d9ffe3c22988b5cf4fb",
"assets/assets/tilesets/jade/CHARACTER_4.png": "0f8d4f815aa1297fcae16079b987aa00",
"assets/assets/tilesets/jade/CHARACTER_5.png": "8cb1ea733750d3f42abd0c72b71eb255",
"assets/assets/tilesets/jade/CHARACTER_6.png": "e2ef8ad8c13d0b09f9d37add0d7a8569",
"assets/assets/tilesets/jade/CHARACTER_7.png": "896d5bdf78a41803cb0b15e159236c7d",
"assets/assets/tilesets/jade/CHARACTER_8.png": "3863f32821137054a7dbc26c3b0a4946",
"assets/assets/tilesets/jade/CHARACTER_9.png": "68881c789be377bee5399816afaee03b",
"assets/assets/tilesets/jade/DRAGON_1.png": "fb365f8a12beb1d6208ac3e81f310649",
"assets/assets/tilesets/jade/DRAGON_2.png": "31e483838a416e04cc7610d2068edcf2",
"assets/assets/tilesets/jade/DRAGON_3.png": "370a08d220ec57f2cf9e400b775bbde8",
"assets/assets/tilesets/jade/FLOWER_1.png": "dbddf80f8dd523ca40f316fca4e2f350",
"assets/assets/tilesets/jade/FLOWER_2.png": "b1355039c6e53c347fd319a1c9d9d437",
"assets/assets/tilesets/jade/FLOWER_3.png": "a96c40b04386f86b0d35566689281d2b",
"assets/assets/tilesets/jade/FLOWER_4.png": "90440106ad523658335bbe98e1c1fe53",
"assets/assets/tilesets/jade/ROD_1.png": "592832d4211be6283bdae57044165013",
"assets/assets/tilesets/jade/ROD_2.png": "82dc489f56f78817cdfa8bf4b81e3f02",
"assets/assets/tilesets/jade/ROD_3.png": "f336286079e6c06b982ac0b557d3d1f7",
"assets/assets/tilesets/jade/ROD_4.png": "65ba15806cdb94e40778720b889bb4a6",
"assets/assets/tilesets/jade/ROD_5.png": "294820e88841e750e7da0c3dc206f2db",
"assets/assets/tilesets/jade/ROD_6.png": "0a2407f32d007199191ade1f6407d6d7",
"assets/assets/tilesets/jade/ROD_7.png": "5b27ba992b9fdddb7f51af7933e32bcf",
"assets/assets/tilesets/jade/ROD_8.png": "0eb58b8ca523914f6d55d3332aa233ca",
"assets/assets/tilesets/jade/ROD_9.png": "0013e8baee68a7382fbc974b70a502d2",
"assets/assets/tilesets/jade/SEASON_1.png": "44a2942e3c7599c5619bfd6656ebcd94",
"assets/assets/tilesets/jade/SEASON_2.png": "df0fe2ea8779df148ecd5d6863fbf162",
"assets/assets/tilesets/jade/SEASON_3.png": "cd6f76bdc81fbe5c885feb0e5cb78668",
"assets/assets/tilesets/jade/SEASON_4.png": "4e0f3a6b962491802d8d8707f05fc60c",
"assets/assets/tilesets/jade/TILE_1.png": "3ebff3559079ef57a1f082889b0a43ee",
"assets/assets/tilesets/jade/TILE_1_SEL.png": "654136d796fd91f0455efa819e8ff624",
"assets/assets/tilesets/jade/WIND_1.png": "ab0de4982ca74008bd773ce47999ff07",
"assets/assets/tilesets/jade/WIND_2.png": "280f22bfaa27c6f18d276328b02a8a87",
"assets/assets/tilesets/jade/WIND_3.png": "0edabd9baf0be70042db66ea749445bc",
"assets/assets/tilesets/jade/WIND_4.png": "ce56a32113d7bec5b00cf075cd8fe6e1",
"assets/assets/tilesets/jade.copyright": "9225bc968019866a6698b402d338c553",
"assets/assets/tilesets/jade.desktop": "3c09908f3647d0e5db1c4a7e23b593f3",
"assets/assets/tilesets/jade.svg": "8221708ba171d151f99ab2cf45b6881b",
"assets/assets/tilesets/traditional/BAMBOO_1.png": "1d7f8ecf681a52eb81fdd39d8b4d5b48",
"assets/assets/tilesets/traditional/BAMBOO_2.png": "71dd418670639406914c666e5bf2ce9f",
"assets/assets/tilesets/traditional/BAMBOO_3.png": "c802ba6a75940c314678395a7a75fb55",
"assets/assets/tilesets/traditional/BAMBOO_4.png": "704332f823c522107348bd50bd81f9bd",
"assets/assets/tilesets/traditional/BAMBOO_5.png": "8bcdb2107215dbbba004848be1676d99",
"assets/assets/tilesets/traditional/BAMBOO_6.png": "3ca5ff5a2f1dea8d48329b93c44f1149",
"assets/assets/tilesets/traditional/BAMBOO_7.png": "d8ced903f0ffa1fedc43e45a746a995f",
"assets/assets/tilesets/traditional/BAMBOO_8.png": "5b552e82b1b69369aae31ec839b17a03",
"assets/assets/tilesets/traditional/BAMBOO_9.png": "74b0ebaacd3ab7d3e0ac14aadabb26de",
"assets/assets/tilesets/traditional/CHARACTER_1.png": "79eb7de38cfb87e4962da9e6918cfd22",
"assets/assets/tilesets/traditional/CHARACTER_2.png": "924bd2373854857b1b6afd3909efa591",
"assets/assets/tilesets/traditional/CHARACTER_3.png": "04e8cd98c8077c662b353bef073a0c5d",
"assets/assets/tilesets/traditional/CHARACTER_4.png": "24f4ec7a4e048e01156d32565d1d1b95",
"assets/assets/tilesets/traditional/CHARACTER_5.png": "5e7e84bd42fbe0b3228f2f43c5268697",
"assets/assets/tilesets/traditional/CHARACTER_6.png": "80d114d69dca4028f0efaffb508d5af5",
"assets/assets/tilesets/traditional/CHARACTER_7.png": "1f2365f186707cd274047623cfa91fc3",
"assets/assets/tilesets/traditional/CHARACTER_8.png": "64c52e4d8b9c572400520a298f3c92ff",
"assets/assets/tilesets/traditional/CHARACTER_9.png": "3f9fc6f2e41ea6801957a5e54e50e86c",
"assets/assets/tilesets/traditional/DRAGON_1.png": "79b2a79f322b417a6ffccdc7d28c7a04",
"assets/assets/tilesets/traditional/DRAGON_2.png": "db718a6ec9de41d59cf1d4fbe9e17b0d",
"assets/assets/tilesets/traditional/DRAGON_3.png": "aa207b8a19748e10709865dc15acb23a",
"assets/assets/tilesets/traditional/FLOWER_1.png": "eb293d96d2a36f85c335c286ea3ff6ca",
"assets/assets/tilesets/traditional/FLOWER_2.png": "a9a3868fc6418f9b112e3e3888c3bbf3",
"assets/assets/tilesets/traditional/FLOWER_3.png": "3836a76ee453705249a90b94e232804c",
"assets/assets/tilesets/traditional/FLOWER_4.png": "8cf355344738a02435cf86f25a7892a3",
"assets/assets/tilesets/traditional/ROD_1.png": "0f706358e82c14c907346526e0519abe",
"assets/assets/tilesets/traditional/ROD_2.png": "b2954e23940a7e9ff251496dfa09c8c7",
"assets/assets/tilesets/traditional/ROD_3.png": "051cd061818fa8c5989a95676f03ae9f",
"assets/assets/tilesets/traditional/ROD_4.png": "de153aa82a2fe59fae9edd7e27487384",
"assets/assets/tilesets/traditional/ROD_5.png": "7e31500a317771a078f7a556890e566d",
"assets/assets/tilesets/traditional/ROD_6.png": "d617b1ab4eac72669b7f980a589825cd",
"assets/assets/tilesets/traditional/ROD_7.png": "2925eba951d5adbaa97e34cd5ad294fb",
"assets/assets/tilesets/traditional/ROD_8.png": "657339d836ad62a13cab127dad6ffe8b",
"assets/assets/tilesets/traditional/ROD_9.png": "062a7595a3bad8422098764f1164b3dc",
"assets/assets/tilesets/traditional/SEASON_1.png": "9ce23518fd6cd67a5206c881cdcd8ca1",
"assets/assets/tilesets/traditional/SEASON_2.png": "62f10bb4ba17e286fe5fdedf04ddafc4",
"assets/assets/tilesets/traditional/SEASON_3.png": "09fafee83cae04815fda5e40910e5ee4",
"assets/assets/tilesets/traditional/SEASON_4.png": "f71e69668687869cc8f7b4b1ff35e06d",
"assets/assets/tilesets/traditional/TILE_1.png": "de48aab98595dfbf8f24b605d4473d10",
"assets/assets/tilesets/traditional/TILE_1_SEL.png": "07a6dc2553864ec059743397d08dfc42",
"assets/assets/tilesets/traditional/WIND_1.png": "f591b09a73bc498a85b3bdeec05e08f6",
"assets/assets/tilesets/traditional/WIND_2.png": "fa9b224f3ab23ed18d9da9816ae530a0",
"assets/assets/tilesets/traditional/WIND_3.png": "f22d5745cee800d90c27fd3c70bbe44e",
"assets/assets/tilesets/traditional/WIND_4.png": "5b2816f9d9f6f89e07c0e171c24e68de",
"assets/assets/tilesets/traditional.copyright": "601d85a416f33f432e81c476de39b69a",
"assets/assets/tilesets/traditional.desktop": "a099d8cda6afe49f6545252a54d92b89",
"assets/assets/tilesets/traditional.svg": "5229c47dec7705935a0207cfde8bac99",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "094e34a9d1418a3e0155b1671a78d7de",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "f43b565df0683d85c0aa8aa7294f491c",
"icons/Icon-192.png": "ff59ee9a5c48113e63c3630f800742ac",
"icons/Icon-512.png": "542b2558a29e93d3d0fe36c59c0b6028",
"index.html": "58c72937ec6553c6b0810b38e26a0b09",
"/": "58c72937ec6553c6b0810b38e26a0b09",
"main.dart.js": "8a79ab07c34b485a27f752b0d2775fe8",
"manifest.json": "4aedbcf4f8e73872d031d528f0298a15",
"version.json": "1ef2990b6a4bc7e8f052108118f7d092"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
