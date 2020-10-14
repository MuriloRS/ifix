import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/ui/pages/home_page/home_page.dart';
import 'package:ifix/app/ui/themes/myTheme.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_pages.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>.value(
          value: UserModel(null, null),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.SIGNUP, //Rota inicial
        defaultTransition: Transition.fade, // Transição de telas padrão
        getPages: AppPages
            .pages, // Seu array de navegação contendo as rotas e suas pages
        debugShowMaterialGrid: false,
        title: 'iFix',
        theme: appThemeData,
        home: HomePage(), // Page inicial
      )));
}
