// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CallController on _CallControllerBase, Store {
  final _$stateLoadingAtom = Atom(name: '_CallControllerBase.stateLoading');

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

  final _$acceptCallAsyncAction = AsyncAction('acceptCall');

  @override
  Future<void> acceptCall(String mecanicId, String description) {
    return _$acceptCallAsyncAction
        .run(() => super.acceptCall(mecanicId, description));
  }

  final _$refuseCallAsyncAction = AsyncAction('refuseCall');

  @override
  Future<void> refuseCall(String mecanicId) {
    return _$refuseCallAsyncAction.run(() => super.refuseCall(mecanicId));
  }

  final _$updateRatingAsyncAction = AsyncAction('updateRating');

  @override
  Future<void> updateRating(
      DocumentSnapshot snapshot, dynamic description, dynamic rating) {
    return _$updateRatingAsyncAction
        .run(() => super.updateRating(snapshot, description, rating));
  }

  @override
  String toString() {
    final string = 'stateLoading: ${stateLoading.toString()}';
    return '{$string}';
  }
}
