import 'package:flutter/material.dart';
import 'package:ifix/views/tabs/account_tab.dart';
import 'package:ifix/views/tabs/be_mecanic.dart';
import 'package:ifix/views/tabs/configs_tab.dart';
import 'package:ifix/views/tabs/historic_tab.dart';
import 'package:ifix/views/tabs/home_tab.dart';
import 'package:ifix/widgets/drawer.dart';

class Home extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: MenuDrawer(_pageController),
        ),
        Scaffold(
          body: HistoricTab(),
          drawer: MenuDrawer(_pageController),
        ),
        Scaffold(
          body: AccountTab(),
          drawer: MenuDrawer(_pageController),
        ),
        Scaffold(
          body: ConfigsTab(),
          drawer: MenuDrawer(_pageController),
        ),
        Scaffold(
          body: BeMecanic(),
          drawer: MenuDrawer(_pageController),
        ),
      ],
    );
  }
}
