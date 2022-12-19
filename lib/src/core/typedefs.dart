import 'package:flutter/cupertino.dart';

import '../../flutter_getit.dart';

typedef ApplicationDependenciesBuilder = List<Dependency> Function();

typedef DependenciesBuilder = Dependency Function();

typedef DependenciesRegister<T> = T Function(Injector i);

typedef ApplicationBuilder = Widget Function(
    BuildContext context, Widget? child);
