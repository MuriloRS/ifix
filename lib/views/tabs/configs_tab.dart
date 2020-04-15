import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ifix/controllers/configController.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/widgets/sliver_scaffold.dart';
import 'package:mobx/mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ConfigsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    final controller = new ConfigController(userProvider);
    var vehicleController =
        new TextEditingController(text: userProvider.userData['vehicle']);

    autorun((_) {
      if (controller.loadingState == ControllerState.done) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Configurações Salvas!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green[700],
        ));
      }
    });

    return SafeArea(
        child: SliverScaffold(
            content: FormBuilder(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Veículo",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        SizedBox(height: 20),
                        FormBuilderTextField(
                            attribute: 'veiculo',
                            controller: vehicleController,
                            onFieldSubmitted: (s) async {
                              await controller.saveField(s, 'vehicle');
                            },
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "O veículo é obrigatório")
                            ],
                            keyboardType: TextInputType.emailAddress,
                            decoration: Style.textFieldDecoration(
                                Icon(OMIcons.motorcycle))),
                        SizedBox(height: 30),
                        Text("Avaliação mínima",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        SizedBox(height: 20),
                        RatingBar(
                          initialRating: double.parse(
                              userProvider.userData['configs']['rating'].toString()),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          itemSize: 28,
                          onRatingUpdate: (r) {
                            controller.saveField(r, 'rating');
                          },
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 28,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text("Distância máxima",
                            textAlign: TextAlign.start,
                            style: Style.labelFieldStyle()),
                        FormBuilderSegmentedControl(
                          onChanged: (s) =>
                              controller.saveField(s, 'max_distance'),
                          borderColor: Colors.grey[300],
                          padding: EdgeInsets.all(0),
                          unselectedColor: Colors.white,
                          initialValue: userProvider.userData['configs']['max_distance'],
                          decoration: InputDecoration(border: InputBorder.none),
                          attribute: "max_distance",
                          options: [10, 30, 50, 80, 130, 200]
                              .map((number) => FormBuilderFieldOption(
                                    value: number,
                                    child: Text("$number km"),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 10),
                        FormBuilderSwitch(
                          label: Text(
                            'Receber Notificações?',
                            style: Style.labelFieldStyle(),
                          ),
                          onChanged: (s) =>
                              controller.saveField(s, 'notifications'),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(0)),
                          activeColor: Theme.of(context).primaryColor,
                          attribute: "notifications",
                          initialValue: userProvider.userData['configs']['notifications'],
                        ),
                      ],
                    ))),
            title: "Configurações"));
  }
}
