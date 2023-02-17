import 'dart:developer';

import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetitCore extends StatefulWidget {
  List<Dependency> get injections => [];
  WidgetBuilder get view;
  const FlutterGetitCore({super.key});

  @override
  State<FlutterGetitCore> createState() => _FlutterGetitCoreState();
}

class _FlutterGetitCoreState extends State<FlutterGetitCore> {
  List<Dependency> bindings = [];

  @override
  void initState() {
    super.initState();
    // bindings.addAll(widget.injections);
    // log(
    //   name: 'Module',
    //   '${widget.view.toString().replaceAll('Closure: (BuildContext) => ', '')} Initialized',
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bindings.addAll(widget.injections);
      log(
        name: 'Module',
        '${widget.view.toString().replaceAll('Closure: (BuildContext) => ', '')} Initialized',
      );
    });
  }

  void _unRegisterAllBindings() {
    for (var bind in bindings) {
      bind.unRegister();
      log(
        '',
        name: 'Dispose',
        error: '${bind.toString().replaceAll('Instance of ', '')} Disposed',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unRegisterAllBindings();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }
}
