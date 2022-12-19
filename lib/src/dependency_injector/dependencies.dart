import 'package:get_it/get_it.dart';

import '../core/typedefs.dart';
import 'injector.dart';

class Dependency<T extends Object> {
  DependenciesRegister<T> bindRegister;
  bool lazyInstance;

  Dependency._(
    this.bindRegister,
    this.lazyInstance,
  ) {
    final getIt = GetIt.I;
    if (lazyInstance) {
      getIt.registerLazySingleton<T>(() => bindRegister(Injector()));
    } else {
      getIt.registerSingleton<T>(bindRegister(Injector()));
    }
  }

  Dependency._factory(this.bindRegister) : lazyInstance = false {
    // if (!GetIt.I.isRegistered<T>()) {
    GetIt.I.registerFactory<T>(() => bindRegister(Injector()));
    // }
  }

  /// Método responsavel por fazer o unregister da factory dentro do GetIT
  void unRegister() {
    GetIt.I.unregister<T>();
  }

  /// O singleton faz com que toda vez que for solicitado uma nova instancia para o gerenciador de dependencias
  /// ele te dará a mesma instancia.
  /// @param bindRegister nele você deve enviar uma função com o retorno sendo a classe que você gostaria de adicionar ao GetIt
  static Dependency singleton<T extends Object>(
    DependenciesRegister<T> bindRegister,
  ) =>
      Dependency<T>._(bindRegister, false);

  /// O Lazy Singleton faz com que toda vez que for solicitado uma nova instancia
  /// para o gerenciador de dependencias ele te dará a mesma instancia, porém diferente do singleton
  /// esse Dependency não inicia a instancia logo no load da página, será criado somente quando for solicitado pela primeira vez.
  /// @param bindRegister nele você deve enviar uma função com o retorno sendo a classe que você gostaria de adicionar ao GetIt
  static Dependency lazySingleton<T extends Object>(
    DependenciesRegister<T> bindRegister,
  ) =>
      Dependency<T>._(bindRegister, true);

  /// A factory faz com que toda vez que você pedir uma instancia para o gerenciador de dependencias
  /// ele te dara uma nova instancia.
  /// @param bindRegister nele você deve enviar uma função com o retorno sendo a classe que você gostaria de adicionar ao GetIt
  static Dependency factory<T extends Object>(
    DependenciesRegister<T> bindRegister,
  ) =>
      Dependency<T>._factory(bindRegister);
}
