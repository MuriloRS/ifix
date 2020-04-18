import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    return MaterialApp(
        title: 'iFix',
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          /* color: const Color.fromRGBO(150, 11, 25, 1),*/
          primaryColor: const Color.fromRGBO(0, 89, 208, 1),
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserModel>.value(
              value: UserModel(null, null),
            )
          ],
          child: Login(),
        ));
  }
}
