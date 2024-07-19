import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';

class MyService {
  void dispose() {}
}

class MyParamService {
  MyParamService(
    this.title, {
    required this.description,
    this.rating,
  });

  final String title;
  final String description;
  final double? rating;
}

void main() {
  final inject = Injector.inject;

  tearDown(() {
    inject.clear();
  });

  group('Factory:', () {
    test(
      'inject<MyService>() should return a new instance of MyService when is added via addFactory',
      () {
        inject.addFactory<MyService>(
          () => MyService(),
        );

        final firstInstance = inject<MyService>();
        final secondInstance = inject<MyService>();

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isFalse);
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a new instance of MyService "
      "when is added via addFactory(name: 'myService')",
      () {
        inject.addFactory<MyService>(
          () => MyService(),
          name: 'myService',
        );

        final firstInstance = inject<MyService>(name: 'myService');
        final secondInstance = inject<MyService>(name: 'myService');

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isFalse);
      },
    );

    test(
      'inject.getWithParams<MyParamsService>() should return a new instance of MyParamsService when is added via addParamFactory',
      () {
        inject.addFactoryWithParams<MyParamService>(
          (params) => MyParamService(
            params['title'] ?? '',
            description: params['description'] ?? '',
            rating: params['rating'],
          ),
        );

        final firstInstance = inject.getWithParams<MyParamService>(
          params: {
            'title': 'Titulo 1',
            'description': 'Mi descripcion 1',
            'rating': 3.4,
          },
        );

        final secondInstance = inject.getWithParams<MyParamService>(
          params: {
            'title': 'Titulo 2',
            'description': 'Mi descripcion 2',
          },
        );

        expect(firstInstance, isA<MyParamService>());
        expect(secondInstance, isA<MyParamService>());
        expect(firstInstance.title, equals('Titulo 1'));
        expect(secondInstance.title, equals('Titulo 2'));
        expect(firstInstance.rating, equals(3.4));
        expect(secondInstance.rating, isNull);
      },
    );

    test(
      "inject.getWithParams<MyParamsService>(name: 'myParamService') should return a new instance of MyParamsService when is added via addParamFactory",
      () {
        inject.addFactoryWithParams<MyParamService>(
          (params) => MyParamService(
            params['title'] ?? '',
            description: params['description'] ?? '',
            rating: params['rating'],
          ),
          name: 'myParamService',
        );

        final firstInstance = inject.getWithParams<MyParamService>(
          name: 'myParamService',
          params: {
            'title': 'Titulo 1',
            'description': 'Mi descripcion 1',
            'rating': 3.4,
          },
        );

        final secondInstance = inject.getWithParams<MyParamService>(
          name: 'myParamService',
          params: {
            'title': 'Titulo 2',
            'description': 'Mi descripcion 2',
          },
        );

        expect(firstInstance, isA<MyParamService>());
        expect(secondInstance, isA<MyParamService>());
        expect(firstInstance.title, equals('Titulo 1'));
        expect(secondInstance.title, equals('Titulo 2'));
        expect(firstInstance.rating, equals(3.4));
        expect(secondInstance.rating, isNull);
      },
    );
  });

  group('Singleton:', () {
    test(
      'inject<MyService>() should return a same instance of MyService when is added via addSingleton',
      () {
        inject.addSingleton<MyService>(MyService());

        final firstInstance = inject<MyService>();
        final secondInstance = inject<MyService>();

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a same instance of MyService "
      "when is added via addSingleton(name: 'myService')",
      () {
        inject.addSingleton<MyService>(MyService(), name: 'myService');

        final firstInstance = inject<MyService>(name: 'myService');
        final secondInstance = inject<MyService>(name: 'myService');

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );

    test(
      'inject<MyService>() should return a same instance of MyService when is added via addLazySingleton',
      () {
        inject.addLazySingleton<MyService>(() => MyService());

        final firstInstance = inject<MyService>();
        final secondInstance = inject<MyService>();

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a same instance of MyService "
      "when is added via addLazySingleton(name: 'myService')",
      () {
        inject.addLazySingleton<MyService>(() => MyService(),
            name: 'myService');

        final firstInstance = inject<MyService>(name: 'myService');
        final secondInstance = inject<MyService>(name: 'myService');

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );
  });

  group('Async:', () {
    test(
      'inject.getAsync<MyService>() should return a new instance of MyService when is added via addAsyncFactory',
      () async {
        inject.addAsyncFactory<MyService>(() async => MyService());

        final firstInstance = await inject.getAsync<MyService>();
        final secondInstance = await inject.getAsync<MyService>();

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isFalse);
      },
    );

    test(
      "inject.getAsync<MyService>(name: 'myService') should return a new instance of MyService "
      "when is added via addAsyncFactory(name: 'myService')",
      () async {
        inject.addAsyncFactory<MyService>(
          () async => MyService(),
          name: 'myService',
        );

        final firstInstance = await inject.getAsync<MyService>(
          name: 'myService',
        );
        final secondInstance = await inject.getAsync<MyService>(
          name: 'myService',
        );

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isFalse);
      },
    );

    test(
      'inject<MyService>() should return a same instance of MyService when is added via addAsyncSingleton',
      () async {
        inject.addAsyncSingleton<MyService>(() async => MyService());

        await inject.resolveAsync();

        final firstInstance = inject<MyService>();
        final secondInstance = inject<MyService>();

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a single instance of MyService "
      "when is added via addAsyncSingleton(name: 'myService')",
      () async {
        inject.addAsyncSingleton<MyService>(
          () async => MyService(),
          name: 'myService',
        );

        await inject.resolveAsync();

        final firstInstance = inject<MyService>(name: 'myService');
        final secondInstance = inject<MyService>(name: 'myService');

        expect(firstInstance, isA<MyService>());
        expect(secondInstance, isA<MyService>());
        expect(firstInstance.hashCode == secondInstance.hashCode, isTrue);
      },
    );
  });

  group('Exception:', () {
    test(
      'inject<MyService>() should return a StateError when MyService is not registered',
      () {
        expect(
          () => inject<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      'inject.getWithParams<MyParamService>() should return a StateError when MyParamService is not registered',
      () {
        expect(
          () => inject.getWithParams<MyParamService>(params: {}),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a StateError when MyService is not registered",
      () {
        expect(
          () => inject<MyService>(name: 'myService'),
          throwsA(isStateError),
        );
      },
    );

    test(
      'inject.getAsync<MyService>() should return a StateError when MyService is not registered',
      () {
        expect(
          () async => await inject.getAsync<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject.getAsync<MyService>(name: 'myService') should return a StateError when MyService is not registered",
      () {
        expect(
          () async => await inject.getAsync<MyService>(name: 'myService'),
          throwsA(isStateError),
        );
      },
    );

    test(
      'inject<MyService>() should return a StateError when MyService is registered as Async but resolveAsync() is not called before',
      () {
        inject.addAsyncSingleton<MyService>(() async => MyService());

        expect(
          () => inject<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a StateError when MyService is registered as async singleton but resolveAsync() is not called before",
      () {
        inject.addAsyncSingleton<MyService>(
          () async => MyService(),
          name: 'myService',
        );

        expect(
          () => inject<MyService>(name: 'myService'),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject<MyService>() should return a StateError when MyService is registered as async factory",
      () {
        inject.addAsyncFactory<MyService>(
          () async => MyService(),
        );

        expect(
          () => inject<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject<MyService>(name: 'myService') should return a StateError when MyService is registered as async factory",
      () {
        inject.addAsyncFactory<MyService>(
          () async => MyService(),
          name: 'myService',
        );

        expect(
          () => inject<MyService>(name: 'myService'),
          throwsA(isStateError),
        );
      },
    );

    test(
      'inject.getAsync<MyService>() should return a StateError when MyService is registered as Sync',
      () {
        inject.addSingleton<MyService>(MyService());

        expect(
          () async => await inject.getAsync<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject.getAsync<MyService>(name: 'myService') should return a StateError when MyService is registered as Sync",
      () {
        inject.addSingleton<MyService>(
          MyService(),
          name: 'myService',
        );

        expect(
          () async => await inject.getAsync<MyService>(name: 'myService'),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject.getWithParams<MyService>(params: {}) should return a StateError when MyService is registered as Singleton",
      () {
        inject.addSingleton<MyParamService>(
          MyParamService('', description: ''),
        );

        expect(
          () => inject.getWithParams<MyParamService>(params: {}),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject.getWithParams<MyParamService>(name: 'myService', params: {}) should return a StateError when MyParamService is unregistered by name",
      () {
        inject.addSingleton<MyParamService>(
          MyParamService('', description: ''),
        );

        expect(
          () => inject.getWithParams<MyParamService>(
            name: 'myService',
            params: {},
          ),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject.getWithParams<MyService>(name: 'myService', params: {}) should return a StateError when MyService is registered as Singleton",
      () {
        inject.addSingleton<MyParamService>(
          MyParamService('', description: ''),
          name: 'myService',
        );

        expect(
          () => inject.getWithParams<MyParamService>(
            name: 'myService',
            params: {},
          ),
          throwsA(isStateError),
        );
      },
    );
  });

  group('Dispose:', () {
    test(
      'inject<MyService>() should call onDispose callback when MyService is disposed',
      () {
        bool isDisposed = false;
        inject.addSingleton<MyService>(
          MyService(),
          onDispose: (myService) {
            myService.dispose();
            isDisposed = true;
          },
        );

        inject.dispose<MyService>();

        expect(isDisposed, isTrue);

        expect(
          () => inject<MyService>(),
          throwsA(isStateError),
        );
      },
    );

    test(
      "inject<MyService>(name: 'myService') should call onDispose callback when MyService is disposed",
      () {
        bool isDisposed = false;
        inject.addSingleton<MyService>(
          MyService(),
          name: 'myService',
          onDispose: (myService) {
            myService.dispose();
            isDisposed = true;
          },
        );

        inject.dispose<MyService>(name: 'myService');

        expect(isDisposed, isTrue);
      },
    );

    test(
      "clear() should remove all services registered and throw StateError if try to access to any service removed",
      () {
        inject.addSingleton<MyService>(
          MyService(),
          name: 'myService1',
          onDispose: (myService) {
            myService.dispose();
          },
        );

        inject.addLazySingleton<MyService>(
          () => MyService(),
          name: 'myService2',
          onDispose: (myService) {
            myService.dispose();
          },
        );

        inject.clear();

        expect(
          () => inject<MyService>(name: 'myService1'),
          throwsA(isStateError),
        );

        expect(
          () => inject<MyService>(name: 'myService2'),
          throwsA(isStateError),
        );
      },
    );
  });
}
