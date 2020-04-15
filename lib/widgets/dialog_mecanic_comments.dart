import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/widgets/loader.dart';

class DialogMecanicComments extends StatelessWidget {
  String mecanicID;
  DialogMecanicComments(this.mecanicID);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection('mecanics')
            .document(mecanicID)
            .collection('ratings')
            .getDocuments(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState.index == ConnectionState.none.index ||
              snapshot.connectionState.index == ConnectionState.waiting.index) {
            return CupertinoAlertDialog(
              content: Loader(),
            );
          }

          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Fechar"),
                isDefaultAction: true,
                isDestructiveAction: false,
                textStyle: TextStyle(color: Colors.blueAccent[600]),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
            title: Text(
              'Comentários',
              textAlign: TextAlign.center,
            ),
            content: Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height - 300,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Murilo',
                              style: TextStyle(fontSize: 14),
                            ),
                            RatingBar(
                              initialRating: snapshot.data.documents
                                  .elementAt(index)
                                  .data['rating'],
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              glow: false,
                              itemSize: 14,
                              onRatingUpdate: (r) {},
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          snapshot.data.documents
                              .elementAt(index)
                              .data['message'],
                          textAlign: TextAlign.left,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Divider(height: 1, color: Colors.grey[500]),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                  itemCount: snapshot.data.documents.length),
            ),
          );
        });
  }
}
