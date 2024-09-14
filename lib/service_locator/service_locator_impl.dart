part of '../inject.dart';

class _ServiceLocatorImpl implements ServiceLocator {
  _ServiceLocatorImpl._();

  static final _instance = _ServiceLocatorImpl._();
  factory _ServiceLocatorImpl() => _instance;

  final _typedServices = <Type, Service>{};
  final _namedServices = <String, Service>{};

  T call<T>({String? name}) {
    if (name != null) {
      return _ServiceResolver.resolveNamedService<T>(_namedServices, name);
    }

    if (_typedServices.containsKey(T)) {
      return _ServiceResolver.resolveTypedService<T>(_typedServices);
    }

    throw StateError('The $T service wasn\'t registered');
  }

  @override
  Future<T> getAsync<T>({String? name}) {
    if (name != null) {
      return _ServiceResolver.resolveNamedAsyncService<T>(_namedServices, name);
    }

    if (_typedServices.containsKey(T)) {
      return _ServiceResolver.resolveTypedAsyncService<T>(_typedServices);
    }

    throw StateError('The $T service wasn\'t registered');
  }

  @override
  T getWithParams<T>({
    required Map<String, dynamic> params,
    String? name,
  }) {
    if (name != null) {
      return _ServiceResolver.resolveNamedParamService<T>(
        _namedServices,
        name,
        params,
      );
    }

    if (_typedServices.containsKey(T)) {
      return _ServiceResolver.resolveTypedParamService<T>(
        _typedServices,
        params,
      );
    }

    throw StateError('The $T service wasn\'t registered');
  }

  @override
  void addSingleton<T>(
    T instance, {
    String? name,
    ServiceDisposer<T>? onDispose,
  }) {
    final service = SingletonService<T>(
      onDispose: onDispose,
      instance: instance,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  void addAsyncSingleton<T>(
    AsyncServiceCreator<T> create, {
    String? name,
    ServiceDisposer<T>? onDispose,
  }) {
    final service = AsyncSingletonService<T>(
      onDispose: onDispose,
      create: create,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  void addLazySingleton<T>(
    ServiceCreator<T> create, {
    String? name,
    ServiceDisposer<T>? onDispose,
  }) {
    final service = LazySingletonService<T>(
      onDispose: onDispose,
      create: create,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  void addFactory<T>(
    ServiceCreator<T> create, {
    String? name,
  }) {
    final service = FactoryService(
      create: create,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  void addFactoryWithParams<T>(
    ParamServiceCreator<T> create, {
    String? name,
  }) {
    final service = ParamFactoryService(
      create: create,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  void addAsyncFactory<T>(
    AsyncServiceCreator<T> create, {
    String? name,
  }) {
    final service = AsyncFactoryService(
      create: create,
    );

    if (name != null) {
      _namedServices[name] = service;
      return;
    }

    _typedServices[T] = service;
  }

  @override
  Future<void> resolveAsync() async {
    for (final name in _namedServices.keys) {
      if (_namedServices[name] is AsyncSingletonService) {
        final service = _namedServices[name] as AsyncSingletonService;
        _namedServices[name] = await service.resolve();
      }
    }

    for (final type in _typedServices.keys) {
      if (_typedServices[type] is AsyncSingletonService) {
        final service = _typedServices[type] as AsyncSingletonService;
        _typedServices[type] = await service.resolve();
      }
    }
  }

  @override
  void dispose<T>({String? name}) async {
    T? instance;
    Service<T>? serviceDisposed;

    if (name != null && _namedServices.containsKey(name)) {
      instance = _ServiceResolver.resolveNamedService<T>(_namedServices, name);
      serviceDisposed = _namedServices.remove(name) as Service<T>;
    } else if (_typedServices.containsKey(T)) {
      instance = _ServiceResolver.resolveTypedService<T>(_typedServices);
      serviceDisposed = _typedServices.remove(T) as Service<T>;
    }

    if (instance != null &&
        serviceDisposed != null &&
        serviceDisposed.onDispose != null) {
      serviceDisposed.onDispose!(instance);
    }
  }

  @override
  void clear() {
    _namedServices.forEach(_ServiceResolver.disposeService);
    _typedServices.forEach(_ServiceResolver.disposeService);
    _namedServices.clear();
    _typedServices.clear();
  }
}
