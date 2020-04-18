import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/libs/files.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/widgets/loader.dart';
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
}
