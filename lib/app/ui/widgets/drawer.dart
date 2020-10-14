import 'package:flutter/material.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/libs/utils.dart';
import 'package:ifix/app/ui/widgets/drawer_tile.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  final PageController pageController;

  MenuDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Drawer(
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                  userModel.userData['name'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  userModel.userData["email"],
                  textAlign: TextAlign.start,
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DrawerTile(OMIcons.home, "Início", pageController, 0),
            DrawerTile(OMIcons.email, "Contato", pageController, 1),
            DrawerTile(OMIcons.person, "Conta", pageController, 2),
          ],
        ),
      ),
      Expanded(
        child: Container(),
      ),
      Expanded(
        child: Container(),
      ),
      Expanded(
        child: Container(),
      ),
      Expanded(
          flex: 1,
          child: FlatButton(
            onPressed: Utils.openTermos,
            child: Text(
              "Termos e Privacidade",
              style: TextStyle(decoration: TextDecoration.underline),
              textAlign: TextAlign.center,
            ),
          ))
    ]));
  }
}
