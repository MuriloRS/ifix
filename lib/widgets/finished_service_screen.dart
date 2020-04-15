import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/controllers/callController.dart';
import 'package:ifix/libs/style.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class FinishedServiceScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final CallController controller;
  FinishedServiceScreen(this.snapshot, this.controller);

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    double rating;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Avalie o serviço de ${snapshot.data['name']}",
              style: TextStyle(fontSize: 22)),
          SizedBox(
            height: 20,
          ),
          RatingBar(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            glow: false,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (r) {
              rating = r;
            },
          ),
          SizedBox(
            height: 20,
          ),
          FormBuilderTextField(
            attribute: 'descricao',
            initialValue: '',
            maxLines: 5,
            maxLengthEnforced: true,
            keyboardType: TextInputType.multiline,
            minLines: 5,
            controller: descriptionController,
            decoration: Style.textFieldDecoration(null,
                hint: "Descreva o serviço do mecânico, não seja ofensivo."),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OutlineButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                onPressed: () => controller.updateRating(
                    snapshot, descriptionController.text, rating),
                child: Row(
                  children: <Widget>[
                    Text("Enviar",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      OMIcons.send,
                      color: Colors.red,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
