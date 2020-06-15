import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifix/controllers/loginController.dart';
import 'package:ifix/libs/dialogs.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class DialogLogin extends StatelessWidget {
  final LoginController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  DialogLogin(this.controller, this._scaffoldKey);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
          key: _fbKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Email*",
                  textAlign: TextAlign.start, style: Style.labelFieldStyle()),
              FormBuilderTextField(
                  attribute: 'email',
                  controller: emailController,
                  maxLines: 1,
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "O email é obrigatório"),
                    FormBuilderValidators.email(errorText: "Email inválido")
                  ],
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      Style.textFieldDecoration(Icon(OMIcons.alternateEmail))),
              SizedBox(
                height: 15,
              ),
              Text("Senha*",
                  textAlign: TextAlign.start, style: Style.labelFieldStyle()),
              FormBuilderTextField(
                  attribute: 'senha',
                  controller: passwordController,
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "A senha é obrigatória")
                  ],
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  decoration: Style.textFieldDecoration(Icon(OMIcons.lock))),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Observer(
                    name: 'Login observer',
                    builder: (_) {
                      return controller.stateLoading ==
                              ControllerState.loadingLogin
                          ? Loader()
                          : Builder(
                              builder: (context) {
                                return RaisedButton(
                                  onPressed: () async {
                                    if (_fbKey.currentState.validate()) {
                                      controller.signIn(emailController.text,
                                          passwordController.text);
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text("Entrar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  color: Theme.of(context).primaryColor,
                                );
                              },
                            );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      new Dialogs().recoverPassword(context, controller);
                    },
                    child: Text("Esqueci minha senha",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                  ))
            ],
          )),
    );
  }
}
