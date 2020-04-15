// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigController on _ConfigControllerBase, Store {
  final _$loadingStateAtom = Atom(name: '_ConfigControllerBase.loadingState');

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

  final _$saveFieldAsyncAction = AsyncAction('saveField');

  @override
  Future<void> saveField(dynamic value, dynamic field) {
    return _$saveFieldAsyncAction.run(() => super.saveField(value, field));
  }

  @override
  String toString() {
    final string = 'loadingState: ${loadingState.toString()}';
    return '{$string}';
  }
}
