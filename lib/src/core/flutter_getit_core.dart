import 'package:flutter/material.dart';

import '../../flutter_getit.dart';

abstract class FlutterGetitCore extends StatefulWidget {
  List<Dependencie> get injections => [];
  WidgetBuilder get view;
  executeOnInit() {}
  executeOnReady() {}
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.executeOnReady();
    });
  }

  void _unRegisterAllBindings() {
    for (var bind in bindings) {
      bind.unRegister();
    }
  }

  @override
  void dispose() {
    _unRegisterAllBindings();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.view(context);
  }

  @override
  void reassemble() {
    // _unRegisterAllBindings();
    // widget.injections;
    super.reassemble();
  }
}
