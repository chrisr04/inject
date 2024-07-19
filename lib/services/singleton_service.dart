import 'package:injector/services/service.dart';

/// A singleton service class that extends the `Service` class.
///
/// The `SingletonService` class provides a way to manage a single instance
/// of a service throughout the application's lifecycle.
///
/// This class is generic, meaning it can be used with any type [T].
///
/// The [instance] of the service is required and must be passed during
/// the initialization of the `SingletonService`.
///
/// Example usage:
/// ```dart
/// final myService = SingletonService<MyService>(
///   instance: MyService(),
///   onDispose: (instance) => instance.dispose(),
/// );
/// ```
class SingletonService<T> extends Service<T> {
  /// Creates a `SingletonService` with the given `instance`.
  ///
  /// The `onDispose` callback is optional and can be provided to perform
  /// any cleanup when the service is disposed.
  SingletonService({
    super.onDispose,
    required this.instance,
  });

  /// The single instance of the service.
  final T instance;
}
