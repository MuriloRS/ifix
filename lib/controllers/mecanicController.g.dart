// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mecanicController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MecanicController on _MecanicControllerBase, Store {
  final _$loadingStateAtom = Atom(name: '_MecanicControllerBase.loadingState');

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

  @override
  String toString() {
    final string = 'loadingState: ${loadingState.toString()}';
    return '{$string}';
  }
}
