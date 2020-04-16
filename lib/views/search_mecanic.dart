import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifix/controllers/callController.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/home.dart';
import 'package:ifix/widgets/finished_service_screen.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:ifix/widgets/mecanic_founded_screen.dart';
import 'package:ifix/widgets/progress_service_screen.dart';
import 'package:mobx/mobx.dart';
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
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('mecanics')
                        .document(widget.mecanic['id'])
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return Loader();
                      } else if (snapshot.data['call'] != null &&
                              (snapshot.connectionState.index ==
                                  ConnectionState.done.index ||
                          snapshot.connectionState.index ==
                              ConnectionState.active.index)) {
                        if (snapshot.data['call']['state'] == 'IN_PROGRESS') {
                          Navigator.of(context).pop();

                          return ProgressServiceScreen(snapshot.data);
                        } else if (snapshot.data['call']['state'] ==
                            'FINISHED') {
                          return FinishedServiceScreen(
                              snapshot.data, controller);
                        }
                      } else if (controller.stateLoading ==
                          ControllerState.loading) {
                        return Loader();
                      }

                      return MecanicFoundedScreen(
                          widget.mecanic, widget.distance, controller);
                    }))));
  }
}
