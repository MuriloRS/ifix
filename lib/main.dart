import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/signup.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
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
          color: Colors.white,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            /* color: const Color.fromRGBO(150, 11, 25, 1),*/
            primaryColor: const Color.fromRGBO(0, 89, 208, 1),
          ),
          home: Signup()),
    );
  }
}
