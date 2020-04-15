import 'package:flutter/material.dart';
import 'package:ifix/libs/style.dart';
import 'package:ifix/widgets/sliver_scaffold.dart';

class BeMecanic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SliverScaffold(
      title: "Seja um Mecânico",
      content: Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
                color: Theme.of(context).primaryColor,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      "Cadastre-se como um mecânico ou oficina e aumente seu faturamento",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[100],
                          fontWeight: FontWeight.w400)),
                )),
            SizedBox(
              height: 25,
            ),
            Text("Como funciona?",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 15,
            ),
            Text(
                "- Baixe o aplicativo iFix - Oficinas para android ou ios(em breve)",
                textAlign: TextAlign.left,
                style: Style.beMecanicItemStyle()),
            SizedBox(
              height: 15,
            ),
            Text(
                "- Cadastre os dados básicos da sua oficina, como endereço, telefone, email, serviços.",
                textAlign: TextAlign.left,
                style: Style.beMecanicItemStyle()),
            SizedBox(
              height: 15,
            ),
            Text("- Defina os horários de funcionamento.",
                style: Style.beMecanicItemStyle()),
            SizedBox(
              height: 15,
            ),
            Text(
                "- Espere até receber notificações de novos chamados, eles aparecerão na tela principal do app ou por push notification.",
                textAlign: TextAlign.left,
                style: Style.beMecanicItemStyle()),
            SizedBox(
              height: 25,
            ),
            Text("Baixe agora",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Image.asset(
                    'assets/playstore.png',
                    height: 42,
                  ),
                ),
                GestureDetector(
                  child: Image.asset(
                    'assets/app-store.png',
                    height: 42,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
