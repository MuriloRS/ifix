import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/widgets/loader.dart';
import 'package:ifix/widgets/sliver_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoricTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserModel>(context);
    var formatter = new DateFormat('dd/MM/yyyy');

    return SafeArea(
        child: SliverScaffold(
            title: 'Histórico',
            content: SingleChildScrollView(
                child: FutureBuilder(
                    future: Firestore.instance
                        .collection('users')
                        .document(userProvider.user.uid)
                        .collection('historic')
                        .getDocuments(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState.index ==
                              ConnectionState.none.index ||
                          snapshot.connectionState.index ==
                              ConnectionState.waiting.index) {
                        return Loader();
                      } else {
                        if (snapshot.data.documents.length == 0) {
                          return Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Nenhum histórico ainda.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18)));
                        } else {
                          List<DocumentSnapshot> listHistorical =
                              snapshot.data.documents;

                          return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              height: MediaQuery.of(context).size.height - 85,
                              child: ListView.separated(
                                  itemCount: listHistorical.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 15,
                                    );
                                  },
                                  itemBuilder: (context, i) {
                                    String data = formatter.format(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            ((listHistorical
                                                            .elementAt(i)
                                                            .data['data']
                                                        as Timestamp)
                                                    .millisecondsSinceEpoch)));

                                    String mecanic = listHistorical
                                        .elementAt(i)
                                        .data['mecanic'];

                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(238, 240, 242, 1),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Mecânico: $mecanic",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Text("Data: $data",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                          /*Text(
                                              "Valor: ${listHistorical.elementAt(i).data['valor'].toStringAsFixed(2).toString().replaceFirst('.', ',')}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      0, 188, 31, 1),
                                                  fontWeight: FontWeight.w500))*/
                                        ],
                                      ),
                                    );
                                  }));
                        }
                      }
                    }))));
  }
}
