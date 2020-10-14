import 'package:flutter/material.dart';

class SliverScaffold extends StatelessWidget {
  final Widget content;
  final String title;

  SliverScaffold(
      {@required this.content,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        title: Text(
          title,
          style: TextStyle(color:Colors.black, fontSize: 22),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).primaryColorLight,
              height: 0.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        actionsIconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        floating: true,
        elevation: 0,
        forceElevated: true,
        backgroundColor: Colors.white,
        iconTheme:
            new IconThemeData(color: Colors.black, size: 26),
        snap: true,
      ),
      SliverToBoxAdapter(child: content)
    ]));
  }
}
