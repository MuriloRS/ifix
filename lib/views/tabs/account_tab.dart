import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ifix/controllers/accountController.dart';
import 'package:ifix/libs/files.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:ifix/widgets/sliver_scaffold.dart';
import 'package:mobx/mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    final controller = new AccountController(userProvider);


    autorun((_) {
      if (controller.loadingState == ControllerState.done) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Configurações Salvas!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green[700],
        ));
      }
    });

    return SafeArea(
        child: SliverScaffold(
            content: FormBuilder(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: FutureBuilder(
                      future: new Files().getCities(context),
                      builder: (context, AsyncSnapshot<List<String>> cities) {
                        if (cities.connectionState.index ==
                                ConnectionState.none.index ||
                            cities.connectionState.index ==
                                ConnectionState.waiting.index) {
                          return Loader();
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Nome",
                                      textAlign: TextAlign.start,
                                      style: Style.labelFieldStyle()),
                                  FormBuilderTextField(
                                      attribute: 'name',
                                      initialValue:
                                          userProvider.userData['name'],
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (s) async {
                                        await controller.saveField(s, 'name');
                                      },
                                      decoration: Style.textFieldDecoration(
                                          Icon(OMIcons.person))),
                                  SizedBox(height: 20),
                                  Text("Email",
                                      textAlign: TextAlign.center,
                                      style: Style.labelFieldStyle()),
                                  FormBuilderTextField(
                                      attribute: 'email',
                                      initialValue:
                                          userProvider.userData['email'],
                                      onFieldSubmitted: (s) async {
                                        await controller.saveField(s, 'email');
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: Style.textFieldDecoration(
                                          Icon(OMIcons.alternateEmail))),
                                  /*SizedBox(height: 20),
                                  Text("Cidade",
                                      textAlign: TextAlign.start,
                                      style: Style.labelFieldStyle()),
                                  SimpleAutoCompleteTextField(
                                    clearOnSubmit: false,
                                    textSubmitted: (s) async {
                                      await controller.saveField(s, 'city');
                                    },
                                    controller: cityController,
                                    suggestions: cities.data,
                                    key: autocompleteKey,
                                    decoration: Style.textFieldDecoration(
                                        Icon(OMIcons.map)),
                                  ),*/
                                  SizedBox(height: 20),
                                  Text("Telefone",
                                      textAlign: TextAlign.start,
                                      style: Style.labelFieldStyle()),
                                  FormBuilderTextField(
                                      attribute: 'phone',
                                      initialValue:
                                          userProvider.userData['phone'],
                                      onFieldSubmitted: (s) async {
                                        await controller.saveField(s, 'phone');
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: Style.textFieldDecoration(
                                          Icon(OMIcons.phone))),
                                  SizedBox(height: 20),
                                ],
                              ),
                              FlatButton(
                                  onPressed: () {
                                    controller.deleteAccount(context);
                                  },
                                  child: Text("Excluir Conta",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.red[700])))
                            ],
                          );
                        }
                      },
                    ))),
            title: "Conta"));
  }
}
