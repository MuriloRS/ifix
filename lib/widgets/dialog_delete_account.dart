import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/controllers/accountController.dart';
import 'package:ifix/views/login.dart';
import 'package:ifix/widgets/loader.dart';

class DialogDeleteAccount extends StatefulWidget {
  final AccountController controller;

  DialogDeleteAccount(this.controller);

  @override
  _DialogDeleteAccoutnState createState() => _DialogDeleteAccoutnState();
}

class _DialogDeleteAccoutnState extends State<DialogDeleteAccount> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      actions: <Widget>[
        CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              setState(() {
                loading = true;
              });

              await widget.controller.deleteAccountData();
              
              setState(() {
                loading = false;
              });

              
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text("Sim", style: TextStyle(fontSize: 15))),
        CupertinoActionSheetAction(
            isDefaultAction: false,
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Não", style: TextStyle(fontSize: 15)))
      ],
      content: loading
          ? Loader()
          : Container(
              padding: EdgeInsets.all(15),
              child: Text(
                  "Tem certeza que quer excluir sua conta? Todos os seus dados serão apagados para sempre",
                  style: TextStyle(fontSize: 20)),
            ),
    );
  }
}
