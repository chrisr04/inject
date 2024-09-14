part of '../inject.dart';

/// The `ServiceLocator` class provides methods for registering and retrieving various types of services,
/// including singletons, asynchronous singletons, lazy singletons, factories, and asynchronous factories.
/// It also includes methods for disposing of services and clearing all registrations.
abstract class ServiceLocator {
  /// Adds a singleton instance to the service locator.
  ///
  /// The `instance` parameter is the object to be registered as a singleton.
  /// The optional `name` parameter can be used to register the instance under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addSingleton<T>(
    T instance, {
    String? name,
    ServiceDisposer<T>? onDispose,
  });

  /// Adds an asynchronous singleton to the service locator.
  ///
  /// The `create` parameter is a function that returns a `Future` of the instance to be registered as a singleton.
  /// The optional `name` parameter can be used to register the instance under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addAsyncSingleton<T>(
    AsyncServiceCreator<T> create, {
    String? name,
    ServiceDisposer<T>? onDispose,
  });

  /// Adds a lazy singleton to the service locator.
  ///
  /// The `create` parameter is a function that creates the instance to be registered as a lazy singleton.
  /// The optional `name` parameter can be used to register the instance under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addLazySingleton<T>(
    ServiceCreator<T> create, {
    String? name,
    ServiceDisposer<T>? onDispose,
  });

  /// Adds a factory to the service locator.
  ///
  /// The `create` parameter is a function that creates new instances each time they are requested.
  /// The optional `name` parameter can be used to register the factory under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addFactory<T>(
    ServiceCreator<T> create, {
    String? name,
  });

  /// Adds a factory with dynamic params to the service locator.
  ///
  /// The `create` parameter is a function that creates new instances each time they are requested.
  /// The optional `name` parameter can be used to register the factory under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addFactoryWithParams<T>(
    ParamServiceCreator<T> create, {
    String? name,
  });

  /// Adds an asynchronous factory to the service locator.
  ///
  /// The `create` parameter is a function that returns a `Future` of a new instance each time it is requested.
  /// The optional `name` parameter can be used to register the factory under a specific name.
  /// The optional `onDispose` parameter allows specifying a custom disposal function.
  void addAsyncFactory<T>(
    AsyncServiceCreator<T> create, {
    String? name,
  });

  /// Retrieves an asynchronous instance from the service locator.
  ///
  /// The optional `name` parameter can be used to retrieve the instance registered under a specific name.
  /// Returns a `Future` of the requested instance.
  Future<T> getAsync<T>({String? name});

  /// Retrieves a factory instance with given params from the service locator.
  ///
  /// The `params` parameter is a Map<Symbol, dynamic> of the params for the instance.
  /// The optional `name` parameter can be used to register the factory under a specific name.
  T getWithParams<T>({
    required Map<String, dynamic> params,
    String? name,
  });

  /// Resolves all asynchronous singletons registered in the service locator.
  ///
  /// Returns a `Future` that completes when all asynchronous singletons have been resolved.
  Future<void> resolveAsync();

  /// Disposes of a registered instance.
  ///
  /// The optional `name` parameter can be used to dispose of the instance registered under a specific name.
  void dispose<T>({String? name});

  /// Clears all registrations from the service locator.
  ///
  /// This method removes all registered services and instances from the service locator.
  void clear();
}
