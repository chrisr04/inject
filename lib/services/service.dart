import 'package:inject/types/types.dart';

/// An abstract class that represents a generic service.
///
/// The `Service` class provides a foundation for creating services with
/// optional disposal logic. It is parameterized by a type [T] that represents
/// the type of the service or the resource being managed.
///
/// The primary purpose of this class is to define a structure for services
/// that may require disposal logic when they are no longer needed.
///
/// ```dart
/// class MyService<MyType> extends Service<MyType> {
///   MyService(super.onDispose);
/// }
/// ```
///
/// [T] - The type of the resource or service being managed.
abstract class Service<T> {
  /// Creates a [Service] instance with an optional [onDispose] callback.
  ///
  /// The [onDispose] callback is invoked when the service is disposed, allowing
  /// for cleanup of the resource or service of type [T].
  Service({this.onDispose});

  /// A callback that is called when the service is disposed.
  ///
  /// This callback should contain the logic to dispose of the resource or
  /// service of type [T]. It is optional and can be `null` if no disposal
  /// logic is needed.
  ServiceDisposer<T>? onDispose;
}
