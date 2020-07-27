import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ListenConnectivity {
  static StreamSubscription<ConnectivityResult> streamConnection;
  static ConnectivityResult result;
  static BuildContext _context;
  static bool isShowedAlert = false;

  static void startListen(BuildContext context) {
    ListenConnectivity.streamConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.index == ConnectivityResult.none.index) {
        result = result;
        _context = context;

        showMessageOfflineInternet();
      }
    });
  }

  static void showMessageOfflineInternet() async {
    Toast.show("Sem conexão, por favor se conecte à uma rede.", _context,
        duration: 5);
  }

  static void cancelListen() {
    streamConnection.cancel();
  }
}
