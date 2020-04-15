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
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserModel>.value(
            value: UserModel(null, null),
          )
        ],
        child: MaterialApp(
          title: 'iFix',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            primaryColor: const Color.fromRGBO(0, 89, 208, 1),
            buttonTheme: ButtonThemeData(
              buttonColor: const Color.fromRGBO(226, 16, 5, 1),
            ),
          ),
          home: Login(),
        ));
  }
}
