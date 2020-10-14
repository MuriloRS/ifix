import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/app/controller/accountController.dart';
import 'package:ifix/app/ui/pages/signup_page/signup_page.dart';
import 'package:ifix/app/ui/widgets/loader.dart';

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
    return AlertDialog(
        contentPadding:
            EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 20),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        content: loading
            ? Loader()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                        "Tem certeza que quer excluir sua conta? Todos os seus dados serão apagados para sempre",
                        style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          await widget.controller.deleteAccountData();

                          setState(() {
                            loading = false;
                          });

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text("Sim",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white))),
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Não",
                            style: TextStyle(
                                fontSize: 15, color: Colors.red[700]))),
                  )
                ],
              ));
  }
}
