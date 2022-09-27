import 'package:flutter/cupertino.dart';
import 'package:flutter_getit/src/core/flutter_getit_core.dart';
import 'package:flutter_getit/src/core/typedefs.dart';

import '../../flutter_getit.dart';

class FlutterGetItPermanent extends FlutterGetitCore {
  final Widget? child;
  final ApplicationBuilder? builder;
  final ApplicationDependenciesBuilder? bindingsBuilder;
  final ApplicationDependencies? bindings;

  const FlutterGetItPermanent({
    super.key,
    this.child,
    this.builder,
    this.bindingsBuilder,
    this.bindings,
  }) : assert(
            (bindingsBuilder != null && bindings == null ||
                bindingsBuilder == null && bindings != null),
            'You must send only one of the attributes (bindingBuilder or bindings)');

  @override
  List<Dependencie> get injections {
    var bindingsLoad = <Dependencie>[];

    if (bindings != null) {
      bindingsLoad = bindings!.bindings();
    } else if (bindingsBuilder != null) {
      bindingsLoad = bindingsBuilder!();
    }

    return bindingsLoad;
  }

  @override
  WidgetBuilder get view => (context) {
        if (child != null) {
          return child!;
        } else if (builder != null) {
          return builder!(context, child);
        } else {
          throw Exception('Widget notfound');
        }
      };
      
        
}

abstract class ApplicationDependencies {
  List<Dependencie> bindings();
}
