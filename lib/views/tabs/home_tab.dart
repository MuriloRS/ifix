import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifix/controllers/homeController.dart';
import 'package:ifix/libs/localizations.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/views/search_mecanic.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:ifix/widgets/loading_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    final controller = HomeController(userProvider);
    QuerySnapshot _mecanics;

    autorun((_) async {
      if (controller.loadingState == ControllerState.done) {
        await Future.delayed(Duration(seconds: 1));

        Navigator.of(context).pop();

        if (controller.mecanicSelected['mecanic'] == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                  "Nenhum mecânico encontrado, tente mudar o filtro nas configurações.")));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => SearchMecanic(
                      controller.mecanicSelected['mecanic'],
                      controller.formatDistance(
                          controller.mecanicSelected['distance']))));
        }
      }
    });

    return SafeArea(
        child: Stack(
      children: <Widget>[
        FutureBuilder(
          future: Future.wait([
            controller.getMecanics(),
            new Localization().getInitialLocation(userProvider)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState.index == ConnectionState.none.index ||
                snapshot.connectionState.index ==
                    ConnectionState.waiting.index) {
              return Loader();
            }

            final position = snapshot.data.elementAt(1);
            final CameraPosition _kGooglePlex = CameraPosition(
              target: LatLng(position['latitude'], position['longitude']),
              zoom: 16.4746,
            );

            _mecanics = snapshot.data.elementAt(0);

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              markers: controller.getMapMarkers(snapshot.data.elementAt(0)),
            );
          },
        ),
        Positioned(
            left: 15,
            top: 15,
            child: IconButton(
                color: Colors.black,
                icon: Icon(
                  OMIcons.menu,
                  size: 34,
                  color: Colors.black,
                ),
                onPressed: Scaffold.of(context).openDrawer)),
        Positioned.fill(
          top: 70,
          child: Align(
            alignment: Alignment.topCenter,
            child: RaisedButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                onPressed: () {
                  new LoadingDialog().dialogSearchingMecanic(
                      context, 'Procurando mecânico...');
                  controller.getMostNearMecanic(_mecanics.documents);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Preciso de um Mecânico",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      OMIcons.search,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
        ),
        Positioned.fill(
            top: 120,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text("Ou procure pelo mapa"),
            ))
      ],
    ));
  }
}
