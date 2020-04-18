import 'package:flutter/material.dart';
import 'package:ifix/widgets/drawer_tile.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MenuDrawer extends StatelessWidget {
  final PageController pageController;

  MenuDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      SizedBox(height: 35),
      Container(
        padding: EdgeInsets.only(top: 20, left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Murilo",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "murilo_haas@outlook.com",
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Divider(
        height: 1,
        color: Colors.grey[400],
        indent: 20,
        endIndent: 30,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: <Widget>[
            DrawerTile(OMIcons.home, "Início", pageController, 0),
            DrawerTile(OMIcons.list, "Histórico", pageController, 1),
            DrawerTile(OMIcons.person, "Conta", pageController, 2),
            DrawerTile(OMIcons.settings, "Configurações", pageController, 3),
            DrawerTile(OMIcons.work, "Seja um mecânico", pageController, 4),
          ],
        ),
      ),
    ]));
  }
}
