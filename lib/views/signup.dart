import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifix/controllers/loginController.dart';
import 'package:ifix/libs/dialogs.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/email_confirm.dart';
import 'package:ifix/views/home.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:mobx/mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    var phoneController = new MaskedTextController(mask: '(00) 00000-0000');

    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    final userProvider = Provider.of<UserModel>(context);
    final controller = new LoginController(userProvider);

    autorun((_) {
      if (controller.stateLoading == ControllerState.error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            controller.errorMessage,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      } else if(controller.stateLoading == ControllerState.successRecoverPassword){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            "Te enviamos um email para você recuperar sua senha.",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ));
      }
      else if (controller.stateLoading == ControllerState.done) {
        if (userProvider.user.isEmailVerified) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => Material(child: Home())));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => EmailConfirm()));
        }
      }
    });

    return FutureBuilder(
      future: controller.getUserData(),
      builder: (context, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
        if (snapshot.connectionState.index == ConnectionState.none.index ||
            snapshot.connectionState.index == ConnectionState.waiting.index) {
          return Container(color: Colors.white, child: Loader());
        } else {
          if (snapshot.data != null) {
            userProvider.user = snapshot.data['user'];
            userProvider.userData = snapshot.data['userData'];

            return Home();
          }

          return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: true,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        right: 20, bottom: 20, left: 20, top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/big_logo.png',
                          height: 60,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Faça o seu cadastro",
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        FormBuilder(
                          key: _fbKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nome*",
                                    textAlign: TextAlign.start,
                                    style: Style.labelFieldStyle()),
                                FormBuilderTextField(
                                    attribute: 'nome',
                                    onChanged: controller.changeName,
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "O nome é obrigatório")
                                    ],
                                    keyboardType: TextInputType.text,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.person))),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Email*",
                                    textAlign: TextAlign.start,
                                    style: Style.labelFieldStyle()),
                                FormBuilderTextField(
                                    attribute: 'email',
                                    onChanged: controller.changeEmail,
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "O email é obrigatório"),
                                      FormBuilderValidators.email(
                                          errorText: 'Email inválido')
                                    ],
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.email))),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Telefone*",
                                    textAlign: TextAlign.start,
                                    style: Style.labelFieldStyle()),
                                FormBuilderTextField(
                                    attribute: 'telefone',
                                    controller: phoneController,
                                    onChanged: controller.changePhone,
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "O telefone é obrigatório")
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.phone))),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Senha*",
                                    textAlign: TextAlign.start,
                                    style: Style.labelFieldStyle()),
                                FormBuilderTextField(
                                    attribute: 'senha',
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "A senha é obrigatória")
                                    ],
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    onChanged: controller.changePassword,
                                    maxLines: 1,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.lock))),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: double.infinity,
                                    child: Observer(
                                        name: 'Login observer',
                                        builder: (_) {
                                          return controller.stateLoading ==
                                                  ControllerState.loading
                                              ? Loader()
                                              : RaisedButton(
                                                  onPressed: () {
                                                    if (_fbKey.currentState
                                                        .validate()) {
                                                      controller.doRegister(
                                                          userProvider);
                                                    }
                                                  },
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Cadastrar",
                                                        style: Style
                                                            .primaryButtonStyle(),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Icon(
                                                        OMIcons.arrowForward,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ));
                                        })),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: double.infinity,
                                    child: FlatButton(
                                      onPressed: () => new Dialogs()
                                          .dialogLogin(context, controller),
                                      child: Text("Já tenho conta",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline)),
                                    ))
                              ]),
                        )
                      ],
                    ))),
          );
        }
      },
    );
  }
}
