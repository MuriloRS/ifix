import 'package:flutter/material.dart';
import 'package:ifix/app/ui/pages/tabs/account_tab.dart';
import 'package:ifix/app/ui/pages/tabs/be_mecanic.dart';
import 'package:ifix/app/ui/pages/tabs/configs_tab.dart';
import 'package:ifix/app/ui/pages/tabs/contact_tab.dart';
import 'package:ifix/app/ui/pages/tabs/home_tab.dart';
import 'package:ifix/app/ui/widgets/drawer.dart';

class HomePage extends StatelessWidget {
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
          body: ContactTab(),
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
