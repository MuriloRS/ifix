import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/controllers/mecanicController.dart';
import 'package:ifix/libs/dialogs.dart';
import 'package:ifix/libs/utils.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ModalBottomSheetMecanic extends StatelessWidget {
  MecanicController controller;
  UserModel userModel;
  Map<String, dynamic> mecanicData;

  ModalBottomSheetMecanic(this.mecanicData);

  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<UserModel>(context);
    controller = MecanicController(userModel);

    return Material(
        child: Container(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
          child: userModel.mecanicSelected == null
              ? FutureBuilder(
                  future: controller.getBottomSheetInitialData(mecanicData),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState.index ==
                            ConnectionState.none.index ||
                        snapshot.connectionState.index ==
                            ConnectionState.waiting.index) {
                      return Loader();
                    } else {
                      userModel.mecanicSelected =
                          snapshot.data['mecanic']['data'];

                      return _bottomSheetBody(context);
                    }
                  })
              : _bottomSheetBody(context)),
    ));
  }

  Widget _bottomSheetBody(context) {
    return Column(
      children: <Widget>[
        Text(
          userModel.mecanicSelected['name'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        _getWidgetOpenNow(userModel.mecanicSelected['open_now']),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              userModel.mecanicSelected['rating'].toString(),
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            SizedBox(width: 10),
            RatingBar(
              initialRating: userModel.mecanicSelected['rating'],
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              glow: false,
              itemSize: 32,
              onRatingUpdate: (r) {},
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 32,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            userModel.mecanicSelected['reviews'] != null
                ? IconButton(
                    icon: Icon(OMIcons.comment),
                    onPressed: () => new Dialogs().showReviewsDialog(
                        userModel.mecanicSelected['reviews'], context))
                : Container()
          ],
        ),
        SizedBox(
          height: 5,
        ),
        userModel.mecanicSelected['website'] != null
            ? SizedBox(
                height: 15,
              )
            : Container(),
        userModel.mecanicSelected['website'] != null
            ? GestureDetector(
                onTap: () => controller
                    .launchWebsite(userModel.mecanicSelected['website']),
                child: Row(
                  children: <Widget>[
                    Icon(OMIcons.openInBrowser),
                    SizedBox(
                      width: 5,
                    ),
                    Text(userModel.mecanicSelected['website'],
                        style: TextStyle(decoration: TextDecoration.underline))
                  ],
                ))
            : Container(),
        userModel.mecanicSelected['formattedAddress'] != null
            ? SizedBox(
                height: 15,
              )
            : Container(),
        userModel.mecanicSelected['formattedAddress'] != null
            ? GestureDetector(
                onTap: () => controller.openMap(
                    userModel.mecanicSelected['latitude'],
                    userModel.mecanicSelected['longitude']),
                child: Row(
                  children: <Widget>[
                    Icon(OMIcons.place),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                            Utils.formatAddress(
                                userModel.mecanicSelected['formattedAddress']),
                            maxLines: 3,
                            softWrap: true,
                            style: TextStyle(
                                decoration: TextDecoration.underline)))
                  ],
                ))
            : Container(),
        userModel.mecanicSelected['telephone'] != null
            ? SizedBox(
                height: 15,
              )
            : Container(),
        userModel.mecanicSelected['telephone'] != null
            ? Row(
                children: <Widget>[
                  Icon(OMIcons.phoneAndroid),
                  SizedBox(
                    width: 5,
                  ),
                  Text(userModel.mecanicSelected['telephone'])
                ],
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        userModel.mecanicSelected['telephone'] != null
            ? _getPhoneButtons()
            : Container()
      ],
    );
  }

  Container _getPhoneButtons() {
    return Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Utils.isCellphoneNumber(userModel.mecanicSelected['telephone'])
                ? CupertinoButton(
                    padding: EdgeInsets.all(7),
                    onPressed: () => controller
                        .launchWhatsApp(userModel.mecanicSelected['telephone']),
                    color: Color.fromRGBO(74, 201, 89, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/whatsapp.png",
                          height: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("WHATSAPP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              padding: EdgeInsets.all(10),
              onPressed: () =>
                  controller.callNumber(userModel.mecanicSelected['telephone']),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    OMIcons.phone,
                    size: 32,
                    color: Colors.grey[800],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("LIGAR",
                      style: TextStyle(color: Colors.grey[800], fontSize: 22)),
                ],
              ),
            )
          ],
        ));
  }

  Widget _getWidgetOpenNow(opennow) {
    return opennow == false
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text("Está aberto!", style:TextStyle(fontSize: 16, color:Colors.white)),
                color: Colors.green,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )
        : Container();
  }
}
