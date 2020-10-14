import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/app/libs/snackbar.dart';

class ListenConnectivity {
  static StreamSubscription<ConnectivityResult> streamConnection;
  static ConnectivityResult result;
  static bool isShowedAlert = false;

  static void startListen(BuildContext context) {
    ListenConnectivity.streamConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.index == ConnectivityResult.none.index) {
        result = result;

        showMessageOfflineInternet();
      }
    });
  }

  static void showMessageOfflineInternet() async {
    Snackbar.show(
        message: "Sem conexão, por favor se conecte à uma rede.",
        color: Colors.red);
  }

  static void cancelListen() {
    streamConnection.cancel();
  }
}
