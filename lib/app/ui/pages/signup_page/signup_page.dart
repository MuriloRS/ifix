import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ifix/app/controller/loginController.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/libs/dialogs.dart';
import 'package:ifix/app/libs/listenConnectivity.dart';
import 'package:ifix/app/libs/snackbar.dart';
import 'package:ifix/app/ui/pages/home_page/home_page.dart';
import 'package:ifix/app/ui/themes/myStyles.dart';
import 'package:ifix/app/ui/widgets/loader.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    final userProvider = Provider.of<UserModel>(context);
    final controller = new LoginController(userProvider);

    ListenConnectivity.startListen(context);

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

            return HomePage();
          }

          return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: true,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        right: 20, bottom: 20, left: 20, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/splash.jpg',
                          height: 130,
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
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "O nome é obrigatório")
                                    ],
                                    onChanged: (v) => controller.name = v,
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
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText: "O email é obrigatório"),
                                      FormBuilderValidators.email(
                                          errorText: 'Email inválido')
                                    ],
                                    onChanged: (v) => controller.email = v,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.email))),
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
                                    onChanged: (v) => controller.password = v,
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.lock))),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Obx(
                                      () => Checkbox(
                                        value: controller.checkTerms,
                                        onChanged: (bool value) {
                                          controller.checkTerms =
                                              !controller.checkTerms;
                                        },
                                      ),
                                    ),
                                    FlatButton(
                                      child: Text(
                                          "Termos e Política de Privacidade",
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              decoration:
                                                  TextDecoration.underline)),
                                      onPressed: controller.openTerms,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: double.infinity,
                                    child: Obx(() => controller.stateLoading ==
                                            ControllerState.loading
                                        ? Loader()
                                        : RaisedButton(
                                            onPressed: () {
                                              if (!controller.checkTerms) {
                                                Snackbar.show(
                                                    message:
                                                        "Você precisa aceitar os termos",
                                                    color: Colors.red);
                                                return;
                                              }
                                              if (_fbKey.currentState
                                                  .validate()) {
                                                controller
                                                    .doRegister(userProvider);
                                              }
                                            },
                                            color:
                                                Theme.of(context).primaryColor,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                            )))),
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
