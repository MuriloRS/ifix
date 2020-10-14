import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ifix/app/controller/loginController.dart' as lController;
import 'package:ifix/app/libs/files.dart';
import 'package:ifix/app/ui/themes/myStyles.dart';
import 'package:ifix/app/ui/widgets/dialog_comments.dart';
import 'package:ifix/app/ui/widgets/dialog_login.dart';
import 'package:ifix/app/ui/widgets/loader.dart';
import 'package:ifix/app/ui/widgets/modal_bottom_sheet_mecanic.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class Dialogs {
  void dialogSearchingMecanic(
      context, text, Future<void> Function() refuseCall) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            title: text != null ? Text(text) : null,
            content: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Loader(),
                    refuseCall != null
                        ? SizedBox(
                            height: 15,
                          )
                        : Container(),
                    refuseCall != null
                        ? FlatButton(
                            onPressed: refuseCall,
                            child: Text("Cancelar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)))
                        : Container()
                  ],
                )));
      },
    );
  }

  void dialogUserCity(context, Future<void> Function(String city) updateCity) {
    final cityController = new TextEditingController();
    final autocompleteKey = new GlobalKey<AutoCompleteTextFieldState<String>>();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            title: Text("Coloque sua cidade"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FutureBuilder(
                    future: new Files().getCities(context),
                    builder: (context, AsyncSnapshot<List<String>> cities) {
                      if (cities.connectionState.index ==
                              ConnectionState.none.index ||
                          cities.connectionState.index ==
                              ConnectionState.waiting.index) {
                        return Loader();
                      } else {
                        return SimpleAutoCompleteTextField(
                          clearOnSubmit: false,
                          controller: cityController,
                          suggestions: cities.data,
                          key: autocompleteKey,
                          decoration:
                              Style.textFieldDecoration(Icon(OMIcons.map)),
                        );
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (cityController.text != '') {
                          updateCity(cityController.text);
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "Cadastrar",
                        style: Style.primaryButtonStyle(),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  void dialogLogin(context, lController.LoginController controller) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              titlePadding:
                  EdgeInsets.only(top: 5, bottom: 0, left: 15, right: 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                      icon: Icon(OMIcons.close),
                      highlightColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              contentPadding: EdgeInsets.all(15),
              content: DialogLogin(controller));
        });
  }

  void recoverPassword(context, controller) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    TextEditingController emailController = TextEditingController();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              titlePadding:
                  EdgeInsets.only(top: 5, bottom: 0, left: 15, right: 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Recuperar senha",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                  IconButton(
                      icon: Icon(OMIcons.close),
                      highlightColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              contentPadding: EdgeInsets.all(15),
              content: SingleChildScrollView(
                child: FormBuilder(
                    key: _fbKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("Email*",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        FormBuilderTextField(
                            attribute: 'email',
                            controller: emailController,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "O email é obrigatório"),
                              FormBuilderValidators.email(
                                  errorText: "Email inválido")
                            ],
                            keyboardType: TextInputType.emailAddress,
                            decoration: Style.textFieldDecoration(
                                Icon(OMIcons.alternateEmail))),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          child: Obx(() => controller.stateLoading ==
                                  lController.ControllerState.loadingPassword
                              ? Loader()
                              : RaisedButton(
                                  onPressed: () async {
                                    if (_fbKey.currentState.validate()) {
                                      await controller.recoverPassword(
                                          emailController.text);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text("Enviar email",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  color: Theme.of(context).primaryColor,
                                )),
                        ),
                      ],
                    )),
              ));
        });
  }

  void showBottomSheetMecanic(m, context) {
    showBarModalBottomSheet(
        context: context,
        enableDrag: false,
        bounce: true,
        elevation: 5,
        barrierColor: Colors.black.withOpacity(0.6),
        isDismissible: true,
        builder: (context, scrollController) {
          return ModalBottomSheetMecanic(m);
        });
  }

  void showReviewsDialog(List<dynamic> reviews, context) {
    showBarModalBottomSheet(
        context: context,
        enableDrag: false,
        bounce: false,
        elevation: 5,
        expand: false,
        barrierColor: Colors.black.withOpacity(0.6),
        isDismissible: true,
        builder: (context, scrollController) {
          return DialogComments(reviews);
        });
  }
}
