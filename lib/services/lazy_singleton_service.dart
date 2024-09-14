import 'package:inject/types/types.dart';
import 'package:inject/services/service.dart';

/// A `LazySingletonService` is a specialized `Service` that ensures a single
/// instance of type [T] is created lazily, meaning the instance is created
/// only when it is needed for the first time.
///
/// This class is particularly useful when you want to delay the creation of
/// a service until it is actually required, thereby optimizing resource usage
/// and potentially improving the application's performance.
///
/// ```dart
/// final myLazySingletonService = LazySingletonService<MyType>(
///   create: () => MyType(),
///   onDispose: (instance) => instance.dispose(),
/// );
/// ```
///
/// The `LazySingletonService` requires a `ServiceCreator` of type [T] to
/// instantiate the service. The `onDispose` callback from the base `Service`
/// class can be optionally provided to handle any necessary cleanup when the
/// service is disposed.
class LazySingletonService<T> extends Service<T> {
  /// Creates a `LazySingletonService` instance.
  ///
  /// The `create` parameter is required and should be a `ServiceCreator`
  /// function that returns an instance of [T] when called.
  ///
  /// The `onDispose` parameter is optional and allows you to specify a
  /// callback function that is called when the service is disposed.
  LazySingletonService({
    super.onDispose,
    required this.create,
  });

  /// The `ServiceCreator` function used to lazily create the instance of [T].
  final ServiceCreator<T> create;
}
