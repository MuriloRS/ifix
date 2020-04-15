import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/widgets/loader.dart';

class LoadingDialog {
  void dialogSearchingMecanic(context, text) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          title: text != null ? Text(text) : null,
          content: Container(
              height: 50,
              padding: EdgeInsets.only(top: 10),
              child: Center(child: Loader())),
        );
      },
    );
  }
}
