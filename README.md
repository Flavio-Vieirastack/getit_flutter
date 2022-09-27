# Flutter GetIt

Projeto que permite você utilizar o get_it como um dependency injection porém controlado pelo ciclo de vida do Flutter, fazendo o register e o unregister na navegação da página.

## Existem 4 tipos possíveis de Widgets

- **FlutterGetItPermanent**
- **FlutterGetItPageRoute**
- **FlutterGetItWidget**
- **FlutterGetItPageBuilder**

## Entenda a diferença de cada um deles

### FlutterGetItPermanent

Application binding são os bindings que NUNCA serão removido de dentro do get_it a ideia é disponibilizar as classes que são utilizadas por diversas páginas do sistemas, fazendo com que você não precise declarar em todas as views

**ex:**

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterGetItPermanent(
      bindingsBuilder: () => [
        Dependencie.lazySingleton((i) => UserModel(
            name: '',
            email: ''))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => FlutterGetItPageBuilder(
                binding: () => Dependencie.singleton((i) => HomeController()),
                page: (context) => const HomePage(),
              ),
          '/products': (context) => const ProductsRoute()
        },
      ),
    );
  }
}
```

## Configurando FlutterGetItPermanent

Existem algumas possiblidades de configuração do FlutterGetItPermanent

Descrição dos Atributos

>**child:** Nesse atributo você deve informar o widget que será iniciado normalmente será adicionado o MaterialApp

>**builder:** Esse atributo pode ser utilizado para quando você já quer disponível o BuildContext ou mesmo para buscar alguma classe que foi injetada nos bindings do FlutterGetItPermanent.

>**bindingsBuilder:** Esse atributo você deve informar para fazer os bindings, aconselhamos a utilização dele somente se você tiver poucas classes para adicionar no get_it pois caso tenha uma quantidade grande aconselhamos a utilização do bindings deixando assim seu código muito mais organizado.

>**bindings:** Nesse atribuito você deve enviar uma classe filha de ApplicationBindings esse atributo é utilizado para quando você quer um pouco mais de organização ou mesmo você tem muitos bindings para serem adicionados no inicio da aplicação

Abaixo um exemplo com cada uma das configurações:

ex:
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterGetItPermanent(
      bindingsBuilder: () => [
        Dependencie.lazySingleton((i) => UserModel(
        name: '',
        email: ''))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => FlutterGetItPageBuilder(
                binding: () => Dependencie.singleton((i) => HomeController()),
                page: (context) => const HomePage(),
              ),
          '/products': (context) => const ProductsRoute()
        },
      ),
    );
  }
}
```
Ex: bindings e builder

```dart

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterGetItPermanent(
      bindings: ExampleApplicationBindings(),
      builder: (context, child) {
        debugPrint(
          context.get<UserModel>().email,
        );
        return MaterialApp(
          title: context.get<UserModel>().email,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => FlutterGetItPageBuilder(
                  binding: () => Dependencie.singleton((i) => HomeController()),
                  page: (context) => const HomePage(),
                ),
            '/products': (context) => const ProductsRoute()
          },
        );
      },
    );
  }
}

```

### FlutterGetItPageRoute

Utilizado para controlar por navegação, sendo utilizado especificamente em rotas no Flutter ex

```dart
class ProductsRoute extends FlutterGetItPageRoute {
  const ProductsRoute({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Dependencie.singleton((i) => ProductsController()),
      ];

  @override
  WidgetBuilder get page => (context) => ProductsPage();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/products': (context) => const ProductsRoute()
      },
    );
  }
}
```

## Getter page

Método page você deve retornar uma função com a sua página. No atributo você receberá uma variável context que é o BuildContext da página e com ele você pode recuperar instancias ou fazer o que for necessário.

## Getter bindings

Esse método será a base para a injeção das dependencias, você deve registrar as classes que serão utilizadas na view e o getit_flutter fará o restante.

### FlutterGetItWidget

Essa classe deve ser utilizada quando você quer ter esse mesmo suporte porém para Componentes (Widgets)

```dart
class CounterWidget extends FlutterGetitWidget {
  @override
  List<Dependencie<Object>> get bindings =>
      [Dependencie.lazySingleton((i) => CounterController())];

  const CounterWidget({super.key});

  @override
  WidgetBuilder get widget => (context) => _CounterWidget(
        controller: context.get(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CounterWidget(),
        ],
      ),
    );
  }
}
```

## Getter widget

Método widget você deve retornar uma função com a seu widget(componente), no atributo você receberá uma variável context que é o BuildContext da página e com ele você pode recuperar instancias ou fazer o que for necessário.

## Getter bindings (Identico ao Getter bindings do FlutterGetItPageRoute)

Esse método será a base para a injeção das dependencias, você deve registrar as classes que serão utilizadas na view e o getit_flutter fará o restante.


### FlutterGetItPageBuilder

Esse Widget é um atalho para quando você tem um único binding e não que crir uma classe de Rota;

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => FlutterGetItPageBuilder(
              binding: () => Dependencie.singleton((i) => HomeController()),
              page: (context) => const HomePage(),
            ),
      },
    );
  }
}
```

## Atributo page

Atributo page você deve retornar uma função com a sua página e no atributo você receberá uma variável context que é o BuildContext da página e com ele você pode recuperar instancias ou fazer o que for necessário.

## Atributo binding

Esse atributo você deve retornar o binding que você quer adicionar na página e o getit_flutter fará o restante.

## Binds

Você tem três possibilidades de utilização em todas você deve passar uma função anônima que recebera como parâmetro a classe Injector que te da a possibilidade de buscar uma instancia dentro do motor de injeção no caso o GetIt

### Tipos de registros

- **Bind.singleton**
- **Bind.lazySingleton**
- **Bind.factory**

### Exemplo Completo

```dart
class LoginRoute extends GetItPageRoute {
  
  const LoginRoute({super.key});
  
  @override
  List<Bind> get bindings => [
    Bind.singleton((i) => HomeRepository())
    Bind.lazySingleton((i) => HomeRepository())
    Bind.factory((i) => HomeController())
  ];  
  
  @override
  WidgetBuilder get view => (context) => LoginPage();
}
```

## Diferentes formas de registros

### Factory (Bind.factory)

```dart
    Bind.factory((i) => HomeController())
```

A factory faz com que toda vez que você pedir uma instancia para o gerenciador de dependencias ele te dara uma nova instancia.

#### Singleton (Bind.singleton)

```dart
    Bind.singleton((i) => HomeController())
```

O singleton faz com que toda vez que for solicitado uma nova instancia para o gerenciador de dependencias ele te dará a mesma instancia.

>**Obs:** O Bind.singleton tem a caracteristica de iniciar a classe logo no carregamento da página.

### Lazy Singleton (Bind.lazySingleton)

```dart
    Bind.lazySingleton((i) => HomeController())
```

O Lazy Singleton faz com que toda vez que for solicitado uma nova instancia para o gerenciador de dependencias ele te dará a mesma instancia, porém diferente do singleton esse Bind não inicia a instancia logo no load da página, será criado somente quando for solicitado pela primeira vez.

## Recuperando instancia

Para recuperar a instancia da classe você tem 2 opções utilizando a classe Injector e a extension que adiciona o Injector dentro do BuildContext

### Ex

```dart
Injector.get<HomeController>();

// ou

context.get<HomeController>();
```

### Exemplo utilizando extension no BuildContext

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.get<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(child: Text(controller.name)),
    );
  }
}
```

### Exemplo utilizando Injector

```dart
class HomePage extends StatelessWidget {
  
  final controller = Injector.get<HomeController>();
  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.get<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(child: Text(controller.name)),
    );
  }
}
```

## Exemplo de gerência de estado

Primeiro passo gere a sua bloc controller ela deve estender de FlutterGetItBloc

```dart
class BlocController extends FlutteGetItBloc {
  
}
```

Feito isso crie as suas classes de estado

```dart
class BlocStates {}

class BlocInitial extends BlocStates {
  
}

class BlocLoading extends BlocStates {}

class BlocError extends BlocStates {
  final String message;
  BlocError({
    required this.message,
  });
}

class BlocSucess extends BlocStates {
  final List<AlbumEntity> albuns;
  BlocSucess({
    required this.albuns,
  });
}

```

Com as classes de estado prontas tipe a sua bloc controller com a classe de estado pai e adicone seus codigos aqui. No meu caso é uma busca a api do jsonPlaceHolder

```dart
class BlocController extends FlutteGetItBloc<BlocStates> {
  final AlbumUsecase _albumUsecase;
  BlocController({
    required AlbumUsecase albumUsecase,
  }) : _albumUsecase = albumUsecase;

  Future<void> getAlbumData() async {
    state.add(BlocLoading());
    final data = await _albumUsecase();

    data.fold(
      (l) => state.add(
        BlocError(
          message: l.toString(),
        ),
      ),
      (r) => state.add(
        BlocSucess(albuns: r),
      ),
    );
  }
}
```

Para adicionar os seus estados, basta chamar a variável state e adicionar os seus estados ali.

## Usando os helpers para criar estados de widgets

Para criar os estados da sua tela baseado na sua bloc controller crie uma abstract class que implemente BlocBuildWidget e passe a sua classe de estado pai.

```dart
abstract class BlocBuilder implements BlocBuildWidget<BlocStates> {
  @override
  Widget buidWidget({
    required BuildContext context,
    required AsyncSnapshot<BlocStates> snapShot,
  }) {
    if (snapShot.hasData) {
      final data = snapShot.data;
      log(data.toString());
      if (data is BlocLoading) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (data is BlocSucess) {
        return ListView.separated(
          itemCount: data.albuns.length,
          itemBuilder: (context, index) {
            final albuns = data.albuns[index];
            return ListTile(
              title: Text(albuns.title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  albuns.tumbailUrl,
                ),
              ),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    albuns.url,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      } else if (data is BlocError) {
        return Text(data.message);
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}

```

Aqui escreva todos os widgets que deverão ser buildados em cada estado. Com isso pronto vá na sua controller e faça o with dessa classe.

```dart
class BlocController extends FlutteGetItBloc<BlocStates> with BlocBuilder {
  final AlbumUsecase _albumUsecase;
  BlocController({
    required AlbumUsecase albumUsecase,
  }) : _albumUsecase = albumUsecase;

  Future<void> getAlbumData() async {
    state.add(BlocLoading());
    final data = await _albumUsecase();

    data.fold(
      (l) => state.add(
        BlocError(
          message: l.toString(),
        ),
      ),
      (r) => state.add(
        BlocSucess(albuns: r),
      ),
    );
  }
}
```


Agora na sua tela você poderá chamar os seus estados assim:

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc page'),
      ),
      body: StreamBuilder<BlocStates>(
        stream: bloc.stateOut,
        builder: (context, snapshot) => bloc.buidWidget(
          context: context,
          snapShot: snapshot,
        ),
      ),
    );
  }
}

```

## Escutando estados

O primeiro passo é criar uma abstract class que implemente de BlocStateListener passando a sua classe de estado pai assim:

```dart
abstract class BlocListner implements BlocStateListener<BlocStates> {
  @override
  void buildListenableWidgets({required event, BuildContext? context}) {
    if (event is BlocSucess) {
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Dados carregados com sucesso',
          ),
        ),
      );
    }
  }
}

```

Com isso pronto chame o seu listner na sua BlocController usando o with assim:

```dart
class BlocController extends FlutteGetItBloc<BlocStates> with BlocBuilder, BlocListner {
  final AlbumUsecase _albumUsecase;
  BlocController({
    required AlbumUsecase albumUsecase,
  }) : _albumUsecase = albumUsecase;

  Future<void> getAlbumData() async {
    state.add(BlocLoading());
    final data = await _albumUsecase();

    data.fold(
      (l) => state.add(
        BlocError(
          message: l.toString(),
        ),
      ),
      (r) => state.add(
        BlocSucess(albuns: r),
      ),
    );
  }
}
```


Feito isso no initState da sua tela adicione um listner ao stateOut da sua BlocController


```dart
@override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<BlocController>();
    bloc.stateOut.listen(
      (event) => bloc.buildListenableWidgets(
        event: event,
        context: context,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await bloc.getAlbumData();
      },
    );
  }

```

Para dar dispose a stream basta chamar o metodo close no dispose da sua pagina;

```dart
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

```
## OBS.: Se você olhar o código fonte dos tipos de widget verá que eles são praticamente identicos, porém eles foram criado pensando em um propósito`(Semântica)`, a semântica de um projeto é muito importante para ajudar na manutenção. Sendo assim para você não ter que usar uma classe FlutterGetItRoute em um widget(Componente que não seja uma Page) e deixar o seu projeto totalmente sem sentido, criamos os Widgets certos para cada objetivo 'Page' ou 'Widget'


