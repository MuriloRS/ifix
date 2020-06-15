// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<Map<dynamic, dynamic>> _$newUserComputed;

  @override
  Map<dynamic, dynamic> get newUser => (_$newUserComputed ??=
          Computed<Map<dynamic, dynamic>>(() => super.newUser))
      .value;

  final _$nameAtom = Atom(name: '_LoginControllerBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$cityAtom = Atom(name: '_LoginControllerBase.city');

  @override
  String get city {
    _$cityAtom.context.enforceReadPolicy(_$cityAtom);
    _$cityAtom.reportObserved();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.context.conditionallyRunInAction(() {
      super.city = value;
      _$cityAtom.reportChanged();
    }, _$cityAtom, name: '${_$cityAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_LoginControllerBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$phoneAtom = Atom(name: '_LoginControllerBase.phone');

  @override
  String get phone {
    _$phoneAtom.context.enforceReadPolicy(_$phoneAtom);
    _$phoneAtom.reportObserved();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.context.conditionallyRunInAction(() {
      super.phone = value;
      _$phoneAtom.reportChanged();
    }, _$phoneAtom, name: '${_$phoneAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_LoginControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_LoginControllerBase.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$stateLoadingAtom = Atom(name: '_LoginControllerBase.stateLoading');

  @override
  ControllerState get stateLoading {
    _$stateLoadingAtom.context.enforceReadPolicy(_$stateLoadingAtom);
    _$stateLoadingAtom.reportObserved();
    return super.stateLoading;
  }

  @override
  set stateLoading(ControllerState value) {
    _$stateLoadingAtom.context.conditionallyRunInAction(() {
      super.stateLoading = value;
      _$stateLoadingAtom.reportChanged();
    }, _$stateLoadingAtom, name: '${_$stateLoadingAtom.name}_set');
  }

  final _$isEmailVerifiedAtom =
      Atom(name: '_LoginControllerBase.isEmailVerified');

  @override
  bool get isEmailVerified {
    _$isEmailVerifiedAtom.context.enforceReadPolicy(_$isEmailVerifiedAtom);
    _$isEmailVerifiedAtom.reportObserved();
    return super.isEmailVerified;
  }

  @override
  set isEmailVerified(bool value) {
    _$isEmailVerifiedAtom.context.conditionallyRunInAction(() {
      super.isEmailVerified = value;
      _$isEmailVerifiedAtom.reportChanged();
    }, _$isEmailVerifiedAtom, name: '${_$isEmailVerifiedAtom.name}_set');
  }

  final _$doRegisterAsyncAction = AsyncAction('doRegister');

  @override
  Future<void> doRegister(UserModel model) {
    return _$doRegisterAsyncAction.run(() => super.doRegister(model));
  }

  final _$verifyConfirmationEmailAsyncAction =
      AsyncAction('verifyConfirmationEmail');

  @override
  Future<void> verifyConfirmationEmail() {
    return _$verifyConfirmationEmailAsyncAction
        .run(() => super.verifyConfirmationEmail());
  }

  final _$signInAsyncAction = AsyncAction('signIn');

  @override
  Future<void> signIn(dynamic email, dynamic password) {
    return _$signInAsyncAction.run(() => super.signIn(email, password));
  }

  final _$recoverPasswordAsyncAction = AsyncAction('recoverPassword');

  @override
  Future<void> recoverPassword(dynamic email) {
    return _$recoverPasswordAsyncAction.run(() => super.recoverPassword(email));
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic changeName(dynamic newName) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeName(newName);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeCity(dynamic newCity) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeCity(newCity);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(dynamic newValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeEmail(newValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePhone(dynamic newValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changePhone(newValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(dynamic newValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changePassword(newValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'name: ${name.toString()},city: ${city.toString()},email: ${email.toString()},phone: ${phone.toString()},errorMessage: ${errorMessage.toString()},password: ${password.toString()},stateLoading: ${stateLoading.toString()},isEmailVerified: ${isEmailVerified.toString()},newUser: ${newUser.toString()}';
    return '{$string}';
  }
}
