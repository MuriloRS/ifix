import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final Color color;
  Loader({this.color=Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCircle(
      size: 32,
      color: color,
    ));
  }
}
