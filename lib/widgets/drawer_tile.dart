import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class DrawerTile extends StatelessWidget {
  final PageController pageController;
  final IconData icon;
  final String text;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () async{
              Navigator.of(context).pop();
              if (this.page == -1) {
                final Email email = Email(
                  recipients: ['murilo08inter@gmail.com'],
                );

                await FlutterEmailSender.send(email);
              } else {
                pageController.jumpToPage(this.page);
              }
            },
            child: Container(
              padding: EdgeInsets.only(left: 25),
              height: 60.0,
              child: Row(
                children: <Widget>[
                  Icon(icon,
                      size: 24.0,
                      color: pageController.page.round() == this.page
                          ? Theme.of(context).primaryColor
                          : Colors.grey[800]),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: pageController.page.round() == this.page
                            ? Theme.of(context).primaryColor
                            : Colors.grey[800]),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
