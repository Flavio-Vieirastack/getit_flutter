import 'dart:developer';

import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetitCore extends StatefulWidget {
  List<Dependencie> get injections => [];
  WidgetBuilder get view;
  void executeOnInit() {}
  void executeOnReady() {}
  void executeOnClose() {}
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
    widget.executeOnInit();
    log(
      name: 'Module',
      '${widget.view.toString().replaceAll('(BuildContext) =>', '')} initialized',
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.executeOnReady(),
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
    widget.executeOnClose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }
}
