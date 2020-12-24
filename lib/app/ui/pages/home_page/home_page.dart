import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/ui/pages/tabs/account_tab.dart';
import 'package:ifix/app/ui/pages/tabs/be_mecanic.dart';
import 'package:ifix/app/ui/pages/tabs/configs_tab.dart';
import 'package:ifix/app/ui/pages/tabs/contact_tab.dart';
import 'package:ifix/app/ui/pages/tabs/home_tab.dart';
import 'package:ifix/app/ui/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final userProvider = Provider.of<UserModel>(context);

            userProvider.setGoogleKey(snapshot.data);

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
        });
  }

  Future<String> setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    await remoteConfig.fetch();
    await remoteConfig.activateFetched();

    return remoteConfig.getValue('api_google').asString();
  }
}
