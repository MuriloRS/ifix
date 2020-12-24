import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';
import 'package:ifix/app/libs/snackbar.dart';
import 'package:ifix/app/ui/widgets/dialog_delete_account.dart';

enum ControllerState { initial, loading, done, error }

class AccountController extends GetxController {
  UserModel model;
  AccountController(this.model);

  final repository = FirebaseRepository();

  final _state = ControllerState.initial.obs;
  set loadingState(value) => this._state.value = value;
  get loadingState => this._state.value;

  Future<void> saveField(value, field) async {
    loadingState = ControllerState.loading;

    Map newData = model.userData;

    switch (field) {
      case 'name':
        newData['name'] = value;
        break;
      case 'email':
        newData['email'] = value;
        break;
    }

    model.userData = newData;

    repository.updateDataCollection(
        collection: 'users', uid: model.user.uid, newData: newData);

    Snackbar.show(message: "Configurações salvas!", color: Colors.green);
  }

  Future<void> deleteAccountData() async {
    repository.getAllFromCollection(collection: 'historic').then((historics) {
      Future.forEach(historics.documents, (doc) {
        doc.reference.delete();
      });
    });

    await repository.deleteValueFromCollection(
        collection: 'users', uid: model.user.uid);

    await model.user.delete();

    model.user = null;
    model.userData = null;

    Snackbar.show(message: "Conta excluída com sucesso!", color: Colors.green);
  }

  Future<void> deleteAccount(context) async {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogDeleteAccount(this);
        });
  }

  Future<void> sendContact(assunto, descricao) async {
    loadingState = ControllerState.loading;

    final Email mailOptions = Email(
      body: descricao,
      subject: assunto,
      recipients: ['murilointer2011@hotmail.com'],
      isHTML: true,
    );

    await FlutterEmailSender.send(mailOptions);

    Snackbar.show(message: "E-mail enviado com sucesso!", color: Colors.green);
  }
}
