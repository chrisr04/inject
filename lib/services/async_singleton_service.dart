import 'package:injector/types/types.dart';
import 'package:injector/services/service.dart';
import 'package:injector/services/singleton_service.dart';

/// A service that provides an asynchronous singleton instance of type [T].
///
/// The `AsyncSingletonService` class extends the `Service` class, allowing
/// for the creation of a singleton instance of type [T] asynchronously.
///
/// This service is particularly useful when you need to initialize an instance
/// asynchronously, such as fetching data from a network or performing heavy
/// computations.
///
/// Example:
/// ```dart
/// final service = AsyncSingletonService<MyType>(
///   create: () async => await fetchMyType(),
///   onDispose: (instance) => instance.dispose(),
/// );
///
/// ```
///
/// The `create` callback is required and should return a `Future<T>` that completes
/// with the desired instance. The [onDispose] callback is optional and can be used
/// to perform any cleanup when the singleton is disposed.
///
/// - [T]: The type of the instance managed by this service.
class AsyncSingletonService<T> extends Service<T> {
  /// Creates an [AsyncSingletonService] with the given [create] and optional [onDispose] callbacks.
  ///
  /// The [create] callback is required and is responsible for asynchronously creating
  /// the singleton instance. The [onDispose] callback is optional and can be used to
  /// perform any necessary cleanup when the service is disposed.
  AsyncSingletonService({
    super.onDispose,
    required this.create,
  });

  /// A callback that asynchronously creates the singleton instance.
  final AsyncServiceCreator<T> create;

  /// Resolves and returns the singleton service asynchronously.
  ///
  /// This method waits for the `create` callback to complete and then returns
  /// a `SingletonService` with the created instance and the `onDispose` callback.
  ///
  /// Returns a `Future<SingletonService<T>>` that completes with the singleton service.
  Future<SingletonService<T>> resolve() async => SingletonService<T>(
        instance: await create(),
        onDispose: onDispose,
      );
}
