import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProgressServiceScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;
  ProgressServiceScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "ACEITO!",
                  style: TextStyle(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 32,
                ),
                Image(
                  image: AssetImage('assets/success_icon.png'),
                  height: 64,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
                "Aguarde o mecânico chegar, deve demorar em média ${snapshot.data['call']['time']} minutos.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800])),
            Text("Seja educado e explique o problema do seu veículo.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]))
          ],
        ));
  }
}
