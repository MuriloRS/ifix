import 'package:flutter/material.dart';

class Style {
  static textFieldDecoration(Icon icon, {String hint = ''}) {
    return InputDecoration(
        hintText: hint,
        isDense: true,
        suffixIcon: icon,
        fillColor: Color.fromRGBO(235, 235, 235, 1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(color: Color.fromRGBO(235, 235, 235, 1), width: 1.0),
        ),
        filled: true,
        border: OutlineInputBorder(
            gapPadding: 1,
            borderRadius: BorderRadius.all(Radius.circular(10))));
  }

  static labelFieldStyle() {
    return TextStyle(
      fontSize: 18,
    );
  }

  static primaryButtonStyle() {
    return TextStyle(fontSize: 22, color: Colors.white);
  }

  static beMecanicItemStyle() {
    return TextStyle(fontSize: 16);
  }
}
