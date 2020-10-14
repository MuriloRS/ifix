import 'package:flutter/material.dart';
import 'package:ifix/app/controller/loginController.dart';
import 'package:ifix/app/data/model/userModel.dart';

import 'package:provider/provider.dart';

class EmailConfirm extends StatelessWidget {
  EmailConfirm();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);

    final GlobalKey<ScaffoldState> _fbKey = GlobalKey<ScaffoldState>();
    final controller = new LoginController(userProvider);

    return Scaffold(
        key: _fbKey,
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        body: Container(
            padding: EdgeInsets.all(25),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Te enviamos um email para você confirmar sua conta.",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: controller.verifyConfirmationEmail,
                  child: Text("CONFIRMEI !",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                )
              ],
            ))));
  }
}
