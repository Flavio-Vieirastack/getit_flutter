import 'package:get_it/get_it.dart';

void resetLazySingleton<T extends Object>() {
  GetIt.I.resetLazySingleton<T>();
}
