import 'dart:developer';

import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetitCore extends StatefulWidget {
  List<Dependencie> get injections => [];
  WidgetBuilder get view;
  const FlutterGetitCore({super.key});

  @override
  State<FlutterGetitCore> createState() => _FlutterGetitCoreState();
}

class _FlutterGetitCoreState extends State<FlutterGetitCore> {
  List<Dependencie> bindings = [];

  @override
  void initState() {
    super.initState();
    bindings.addAll(widget.injections);
    log(
      name: 'Module',
      '${widget.view.toString().replaceAll('Closure: (BuildContext) => ', '')} initialized',
    );
  }

  void _unRegisterAllBindings() {
    for (var bind in bindings) {
      bind.unRegister();
      log(
        name: 'Dispose',
        '${bind.toString().replaceAll('Instance of ', '')} disposed',
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
