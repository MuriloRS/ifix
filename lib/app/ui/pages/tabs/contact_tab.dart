import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ifix/app/controller/accountController.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/ui/themes/myStyles.dart';
import 'package:ifix/app/ui/widgets/loader.dart';
import 'package:ifix/app/ui/widgets/sliver_scaffold.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ContactTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    var _assuntoController = TextEditingController();
    var _descricaoController = TextEditingController();
    AccountController controller;
    controller = AccountController(userProvider);

    ever(controller.loadingState, (_) {
      if (_ == ControllerState.done) {
        _assuntoController.text = "";
        _descricaoController.text = "";
      }
    });

    return SafeArea(
        child: SliverScaffold(
            content: Padding(
                padding: EdgeInsets.all(20),
                child: FormBuilder(
                  key: _fbKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Entre em contato com nossa equipe e de feedback sobre o aplicativo, reporte falhas ou faça elogios.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Assunto*",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        FormBuilderTextField(
                            attribute: 'assunto',
                            controller: _assuntoController,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "O assunto é obrigatório")
                            ],
                            keyboardType: TextInputType.text,
                            decoration: Style.textFieldDecoration(
                                Icon(OMIcons.person))),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Descrição*",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        FormBuilderTextField(
                            attribute: 'descricao',
                            controller: _descricaoController,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "A descrição é obrigatória"),
                            ],
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 5,
                            decoration:
                                Style.textFieldDecoration(Icon(OMIcons.email))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            child: Obx(() => controller.loadingState ==
                                    ControllerState.loading
                                ? Loader()
                                : RaisedButton(
                                    onPressed: () {
                                      if (_fbKey.currentState.validate()) {
                                        controller.sendContact(
                                            _assuntoController.text,
                                            _descricaoController.text);
                                      }
                                    },
                                    color: Theme.of(context).primaryColor,
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
                                          "Enviar",
                                          style: Style.primaryButtonStyle(),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          OMIcons.send,
                                          color: Colors.white,
                                        )
                                      ],
                                    )))),
                      ]),
                )),
            title: "Contato"));
  }
}
