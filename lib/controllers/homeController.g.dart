// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$loadingStateAtom = Atom(name: '_HomeControllerBase.loadingState');

  @override
  ControllerState get loadingState {
    _$loadingStateAtom.context.enforceReadPolicy(_$loadingStateAtom);
    _$loadingStateAtom.reportObserved();
    return super.loadingState;
  }

  @override
  set loadingState(ControllerState value) {
    _$loadingStateAtom.context.conditionallyRunInAction(() {
      super.loadingState = value;
      _$loadingStateAtom.reportChanged();
    }, _$loadingStateAtom, name: '${_$loadingStateAtom.name}_set');
  }

  final _$mecanicSelectedAtom =
      Atom(name: '_HomeControllerBase.mecanicSelected');

  @override
  dynamic get mecanicSelected {
    _$mecanicSelectedAtom.context.enforceReadPolicy(_$mecanicSelectedAtom);
    _$mecanicSelectedAtom.reportObserved();
    return super.mecanicSelected;
  }

  @override
  set mecanicSelected(dynamic value) {
    _$mecanicSelectedAtom.context.conditionallyRunInAction(() {
      super.mecanicSelected = value;
      _$mecanicSelectedAtom.reportChanged();
    }, _$mecanicSelectedAtom, name: '${_$mecanicSelectedAtom.name}_set');
  }

  final _$getMostNearMecanicAsyncAction = AsyncAction('getMostNearMecanic');

  @override
  Future<dynamic> getMostNearMecanic(List<DocumentSnapshot> mecanics) {
    return _$getMostNearMecanicAsyncAction
        .run(() => super.getMostNearMecanic(mecanics));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  Future<QuerySnapshot> getMecanics() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.getMecanics();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loadingState: ${loadingState.toString()},mecanicSelected: ${mecanicSelected.toString()}';
    return '{$string}';
  }
}
