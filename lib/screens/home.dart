import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  static const Route = '/';
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const levels = [
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line",
      "Line"
    ];

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Mahjong'),
      ),
      body:
          /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Consumer<LayoutMetaCollection?>(
            builder: (context, LayoutMetaCollection? layouts, child) {
          final List<LayoutMeta> list =
              layouts == null ? [] : [...layouts.list()];
          list.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final item = list[index];
              return InkWell(
                child: Container(
                  height: 50,
                  child: Center(child: Text(item.name.toString())),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    GamePage.Route,
                    arguments: GamePageArguments(item.basename),
                  );
                },
              );
            },
            addAutomaticKeepAlives: false,
            itemExtent: 50,
          );
        }),
      )*/
          SvgPicture.asset("assets/tilesets/classic.svg",
              semanticsLabel: 'A red up arrow'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/settings',
          );
        },
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }
}
