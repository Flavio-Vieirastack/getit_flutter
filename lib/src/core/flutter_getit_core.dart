import 'dart:developer';

import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetitCore extends StatefulWidget {
  List<Dependencie> get injections => [];
  WidgetBuilder get view;
  onClose() {}
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
      '${widget.view.toString()} initialized',
    );
  }

  void _unRegisterAllBindings() {
    for (var bind in bindings) {
      bind.unRegister();
      log(
        error: 'Dispose',
        '${bind.toString()} disposed',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unRegisterAllBindings();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }
}
