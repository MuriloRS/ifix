import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ButtonTime extends StatelessWidget {
  final tooltip;
  ButtonTime(this.tooltip);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(OMIcons.accessTime), onPressed: () => tooltip.show(context));
  }
}
