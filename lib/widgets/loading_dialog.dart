import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/widgets/loader.dart';

class LoadingDialog {
  void dialogSearchingMecanic(context, text) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(text),
          content: Container(
              padding: EdgeInsets.only(top: 10),
              child: Center(child: Loader())),
        );
      },
    );
  }
}
