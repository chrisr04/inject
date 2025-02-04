part of '../inject.dart';

/// An utility class for resolving services in a service locator.
///
/// The `_ServiceResolver` class provides methods to resolve named and typed
/// services from provided service maps. It supports different service types
/// including synchronous and asynchronous factories, lazy singletons, and
/// singletons.
abstract class _ServiceResolver {
  /// Resolves a named service of type [T] from the provided `namedServices` map.
  ///
  /// Throws a `StateError` if the service with the specified `name` is not
  /// found, or if it is an async service.
  ///
  /// If the service is a `LazySingletonService`, it creates and stores the
  /// singleton instance in the map before returning it.
  static T resolveNamedService<T>(
    Map<String, dynamic> namedServices, {
    required String name,
  }) {
    if (name.isEmpty || !namedServices.containsKey(name)) {
      throw StateError(
        'The service $T with name \'$name\' doesn\'t exist. '
        'make sure to register it before calling inject<$T>(\'$name\')',
      );
    }

    if (namedServices[name] is FutureFactoryService<T>) {
      throw StateError(
        'The service $T can\'t be accessed via inject<$T>(\'$name\'). '
        'call inject.future<$T>(\'$name\') instead',
      );
    }

    if (namedServices[name] is FutureSingletonService<T>) {
      throw StateError(
        'The service $T must be resolved, '
        'make sure to call resolveAsync() before calling inject<$T>(\'$name\')',
      );
    }

    if (namedServices[name] is LazySingletonService<T>) {
      namedServices[name] = SingletonService<T>(
        instance: (namedServices[name] as LazySingletonService<T>).create(),
      );
    }

    return namedServices[name] is FactoryService<T>
        ? (namedServices[name] as FactoryService<T>).create()
        : (namedServices[name] as SingletonService<T>).instance;
  }

  /// Resolves a typed service of type [T] from the provided [typedServices] map.
  ///
  /// Throws a `StateError` if the service is an async service.
  ///
  /// If the service is a `LazySingletonService`, it creates and stores the
  /// singleton instance in the map before returning it.
  static T resolveTypedService<T>(Map<Type, dynamic> typedServices) {
    if (typedServices[T] is FutureFactoryService<T>) {
      throw StateError(
        'The service $T can\'t be accessed via inject<$T>(). '
        'call inject.future<$T>() instead',
      );
    }

    if (typedServices[T] is FutureSingletonService<T>) {
      throw StateError(
        'The service $T must be resolved, '
        'make sure to call resolveAsync() before calling inject<$T>()',
      );
    }

    if (typedServices[T] is LazySingletonService<T>) {
      typedServices[T] = SingletonService<T>(
        instance: (typedServices[T] as LazySingletonService<T>).create(),
      );
    }

    return typedServices[T] is FactoryService<T>
        ? (typedServices[T] as FactoryService<T>).create()
        : (typedServices[T] as SingletonService<T>).instance;
  }

  /// Resolves a named asynchronous service of type [T] from the provided `namedServices` map.
  ///
  /// Throws a `StateError` if the service with the specified `name` is not an
  /// asynchronous factory service.
  static Future<T> resolveNamedFutureService<T>(
    Map<String, dynamic> namedServices, {
    required String name,
  }) {
    if (name.isEmpty || !namedServices.containsKey(name)) {
      throw StateError(
        'The service $T with name \'$name\' doesn\'t exist. '
        'make sure to register it before calling inject.future<$T>(\'$name\')',
      );
    }

    if (namedServices[name] is! FutureFactoryService<T>) {
      throw StateError(
        '$T is not an async factory service, you must use inject<$T>(\'$name\') instead',
      );
    }

    return (namedServices[name] as FutureFactoryService<T>).create();
  }

  /// Resolves a typed asynchronous service of type [T] from the provided `typedServices` map.
  ///
  /// Throws a `StateError` if the service is not an asynchronous factory service.
  static Future<T> resolveTypedFutureService<T>(
    Map<Type, dynamic> typedServices,
  ) {
    if (typedServices[T] is! FutureFactoryService<T>) {
      throw StateError(
        '$T is not an async factory service, you must use inject<$T>() instead',
      );
    }

    return (typedServices[T] as FutureFactoryService<T>).create();
  }

  /// Resolves a named params service of type [T] from the provided `namedServices` map.
  ///
  /// Throws a `StateError` if the service with the specified `name` is not an
  /// asynchronous factory service.
  static T resolveNamedParamService<T>(
    Map<String, dynamic> namedServices, {
    required String name,
    required Map<String, dynamic> params,
  }) {
    if (name.isEmpty || !namedServices.containsKey(name)) {
      throw StateError(
        'The service $T with name \'$name\' doesn\'t exist. '
        'make sure to register it before calling inject.withParams<$T>(name: \'$name\', params: ...)',
      );
    }

    if (namedServices[name] is! ParamFactoryService<T>) {
      throw StateError(
        '$T is not an factory params service, you must use inject<$T>(name: \'$name\') instead',
      );
    }

    return (namedServices[name] as ParamFactoryService<T>).create(params);
  }

  /// Resolves a typed params service of type [T] from the provided `typedServices` map.
  ///
  /// Throws a `StateError` if the service is not an asynchronous factory service.
  static T resolveTypedParamService<T>(
    Map<Type, dynamic> typedServices, {
    required Map<String, dynamic> params,
  }) {
    if (typedServices[T] is! ParamFactoryService<T>) {
      throw StateError(
        '$T is not an factory params service, you must use inject<$T>() instead',
      );
    }

    return (typedServices[T] as ParamFactoryService<T>).create(params);
  }

  /// Resolves a named async params service of type [T] from the provided `namedServices` map.
  ///
  /// Throws a `StateError` if the service with the specified `name` is not an
  /// asynchronous factory service.
  static Future<T> resolveNamedFutureParamService<T>(
    Map<String, dynamic> namedServices, {
    required String name,
    required Map<String, dynamic> params,
  }) {
    if (name.isEmpty || !namedServices.containsKey(name)) {
      throw StateError(
        'The service $T with name \'$name\' doesn\'t exist. '
        'make sure to register it before calling inject.futureWithParams<$T>(name: \'$name\', params: ...)',
      );
    }

    if (namedServices[name] is! FutureParamFactoryService<T>) {
      throw StateError(
        '$T is not an async factory params service, you must use inject<$T>(name: \'$name\') instead',
      );
    }

    return (namedServices[name] as FutureParamFactoryService<T>).create(params);
  }

  /// Resolves a typed async params service of type [T] from the provided `typedServices` map.
  ///
  /// Throws a `StateError` if the service is not an asynchronous factory service.
  static Future<T> resolveTypedFutureParamService<T>(
    Map<Type, dynamic> typedServices, {
    required Map<String, dynamic> params,
  }) {
    if (typedServices[T] is! FutureParamFactoryService<T>) {
      throw StateError(
        '$T is not an async factory params service, you must use inject<$T>() instead',
      );
    }

    return (typedServices[T] as FutureParamFactoryService<T>).create(params);
  }

  /// Calls the `onDispose` method of the given `value` service if it exists.
  ///
  /// The `key` is the identifier for the service, and `value` is the service
  /// instance. Depending on the type of the service, it will either create a
  /// new instance or use the existing one to call the `onDispose` method.
  static void disposeService<T>(T key, dynamic value) {
    final service = value;
    if (service.onDispose == null) return;

    final instance = switch (service) {
      LazySingletonService() => service.create(),
      SingletonService() => service.instance,
      _ => null
    };

    if (instance != null) service.onDispose!(instance);
  }
}
