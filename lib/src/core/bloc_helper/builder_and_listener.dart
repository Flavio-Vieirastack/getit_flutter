import 'package:flutter/material.dart';

import '../../../flutter_getit.dart';

class BlocBuilder<T extends FlutterGetItBloc<T>> extends StatelessWidget {
  final Widget Function(T? state) builder;
  final T? initialData;
  const BlocBuilder({
    Key? key,
    required this.builder,
    this.initialData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream = T as FlutterGetItBloc<T>;
    return StreamBuilder<T>(
      stream: stream.stateOut,
      initialData: initialData,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return builder.call(state);
      },
    );
  }
}

listen<T extends FlutterGetItBloc>(void Function(T state)? execute) {
  final stream = T as FlutterGetItBloc<T>;
  stream.stateOut.listen(execute);
}