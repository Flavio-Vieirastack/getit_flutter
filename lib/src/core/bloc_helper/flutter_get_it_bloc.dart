import 'dart:async';
import 'package:flutter/material.dart';

abstract class FlutteGetItBloc<T extends Object> {
  final state = StreamController<T>.broadcast();

  Stream<T> get stateOut => state.stream;

  Future<void> close() async {
    await stateOut.drain();
    state.close();
  }
}

abstract class BlocBuildWidget<T> {
  Widget buidWidget({
    required BuildContext context,
    required AsyncSnapshot<T> snapshot,
  });
}

abstract class BlocStateListener<T> {
  void buildListenableWidgets({
    required T event,
    BuildContext? context,
  });
}
