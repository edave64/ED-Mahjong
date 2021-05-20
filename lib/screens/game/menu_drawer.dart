import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final bool canShuffle;
  final String? layoutName;
  final Function shuffle;

  MenuDrawer(
      {Key? key,
      required this.canShuffle,
      required this.shuffle,
      this.layoutName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          header(),
          shuffleTile(context),
          exitTile(context),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
        height: 50.0,
        child: DrawerHeader(
          child: Text(layoutName == null ? 'Ingame' : "Ingame: $layoutName"),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ));
  }

  ListTile shuffleTile(BuildContext context) {
    return ListTile(
      enabled: canShuffle,
      title: Text('Shuffle'),
      onTap: () {
        Navigator.pop(context);
        shuffle();
      },
    );
  }

  ListTile exitTile(BuildContext context) {
    return ListTile(
      title: Text('Exit'),
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}
