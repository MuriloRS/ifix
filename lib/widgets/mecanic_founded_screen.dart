import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/controllers/callController.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/widgets/dialog_mecanic_comments.dart';
import 'package:ifix/libs/dialogs.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MecanicFoundedScreen extends StatelessWidget {
  final Map mecanic;
  final String distance;
  final CallController controller;
  MecanicFoundedScreen(this.mecanic, this.distance, this.controller);

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Mecânico encontrado!",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[700])),
            SizedBox(
              height: 35,
            ),
            Text(
              "Nome: ${mecanic['data']['name']}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Avaliação média: ",
                  style: TextStyle(fontSize: 18),
                ),
                RatingBar(
                  initialRating: mecanic['data']['rating'],
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  glow: false,
                  itemSize: 22,
                  onRatingUpdate: (r) {},
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 8,
                  ),
                ),
                IconButton(
                    color: Colors.blueAccent[700],
                    icon: Icon(OMIcons.comment, color: Colors.black),
                    iconSize: 18,
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return DialogMecanicComments(mecanic['id']);
                          });
                    })
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Distância: $distance",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            FormBuilder(
              key: _fbKey,
              child: FormBuilderTextField(
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "Preencha a descrição")
                  ],
                  attribute: 'descricao',
                  initialValue: '',
                  maxLines: 5,
                  maxLengthEnforced: true,
                  minLines: 5,
                  controller: descriptionController,
                  decoration: Style.textFieldDecoration(null,
                      hint:
                          "Descreva o problema que você está tendo com seu veículo, especifique onde você está no momento e qual é o seu veículo.")),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () async {
                    if (_fbKey.currentState.validate()) {
                      new Dialogs().dialogSearchingMecanic(
                          context, 'Aguardando o mecânico aceitar...',
                          () async {
                        await controller.refuseCall(mecanic['id']);
                        Navigator.of(context).pop();
                      });

                      await controller.acceptCall(
                          mecanic['id'], descriptionController.text);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text("CHAMAR!",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Voltar",
                        style: TextStyle(
                            color: Colors.grey[800],
                            decoration: TextDecoration.underline))))
          ],
        ));
  }
}
