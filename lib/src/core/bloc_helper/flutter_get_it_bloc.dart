import 'dart:async';
import 'package:flutter/material.dart';

abstract class FlutterGetItBloc<T extends Object> {
  final state = StreamController<T>.broadcast();

  Stream<T> get stateOut => state.stream;
  void emit(T event) {
    state.add(event);
  }

  Future<void> close({
    bool enableDrain = true,
  }) async {
    if (enableDrain) {
      await stateOut.drain();
    }
    state.close();
  }
}

abstract class BlocBuildWidget<T> {
  Widget buildWidget({
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