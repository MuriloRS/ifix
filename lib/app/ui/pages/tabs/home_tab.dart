import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifix/app/controller/homeController.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/ui/widgets/loader.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    final controller = HomeController(userProvider);

    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: Future.wait([
            controller.getMecanicsFromGoogle(context),
            controller.getIconMarker()
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState.index == ConnectionState.none.index ||
                snapshot.connectionState.index ==
                    ConnectionState.waiting.index) {
              return Loader();
            }

            final position = snapshot.data.elementAt(0) == null
                ? {"latitude": -29.7123533, "longitude": -52.4358913}
                : snapshot.data.elementAt(0)['userLocation'];
            final CameraPosition _kGooglePlex = CameraPosition(
              target: LatLng(position['latitude'], position['longitude']),
              zoom: 14.9746,
            );

            return GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              buildingsEnabled: false,
              cameraTargetBounds: CameraTargetBounds.unbounded,
              compassEnabled: true,
              indoorViewEnabled: false,
              mapToolbarEnabled: true,
              rotateGesturesEnabled: false,
              markers: controller.getMapMarkers(
                  snapshot.data.elementAt(0)['mecanics'],
                  snapshot.data.elementAt(1),
                  context),
            );
          },
        ),
        Positioned(
            left: 15,
            top: 35,
            child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(
                          1.0, // horizontal, move right 10
                          2.0, // vertical, move down 10
                        ),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    color: Colors.black,
                    icon: Icon(
                      OMIcons.menu,
                      size: 28,
                      color: Colors.black,
                    ),
                    onPressed: Scaffold.of(context).openDrawer))),
        /*Positioned.fill(
          top: 100,
          child: Align(
            alignment: Alignment.topCenter,
            child: RaisedButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                onPressed: ()=> Dialogs().showBottomSheetMecanic(null, context) ,
                color: Colors.black,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Preciso de um Mecânico",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
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
            top: 150,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text("Ou procure pelo mapa"),
            ))*/
      ],
    );
  }
}
