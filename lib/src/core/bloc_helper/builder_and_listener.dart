import 'package:flutter/material.dart';

import '../../../flutter_getit.dart';



listen<T extends FlutterGetItBloc>(void Function(T state)? execute) {
  final stream = T as FlutterGetItBloc<T>;
  stream.stateOut.listen(execute);
}