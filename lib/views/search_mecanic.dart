import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/controllers/callController.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/home.dart';
import 'package:mobx/mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class SearchMecanic extends StatefulWidget {
  final Map mecanic;
  final String distance;
  SearchMecanic(this.mecanic, this.distance);
  @override
  _SearchMecanicState createState() => _SearchMecanicState();
}

class _SearchMecanicState extends State<SearchMecanic> {
  CallController controller;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    controller = CallController(userProvider);

    autorun((_) {
      if (controller.stateLoading == ControllerState.done_call) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => Home()));
      }
    });

    return Material(
        child: SafeArea(
            child: Center(
                child: Container(
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
                          "Nome: ${widget.mecanic['data']['name']}",
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
                              initialRating: widget.mecanic['data']['rating'],
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
                                icon:
                                    Icon(OMIcons.comment, color: Colors.black),
                                iconSize: 18,
                                onPressed: () {
                                  /* showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return DialogMecanicComments(mecanic['id']);
                          });*/
                                })
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Distância: ${widget.distance}",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox()
                      ],
                    )))));
  }
}
