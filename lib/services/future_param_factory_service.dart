import 'package:inject/types/types.dart';
import 'package:inject/services/service.dart';

/// A service class that creates and manages an instance of a specific type [T].
///
/// The `FutureParamFactoryService` class extends the [Service] class and provides
/// a factory method to create an instance of type [T] with parameters. This is useful when
/// you need to lazily instantiate objects or create multiple instances
/// of a type on demand with specific arguments.
///
/// The [create] parameter is a required callback that defines how the instance
/// of type [T] is created. You can also provide an optional [onDispose]
/// callback to clean up resources when the service is disposed.
///
/// ```dart
/// FutureParamFactoryService<MyService>(
///   create: (params) async {
///     // Perform async operations to initialize MyService
///     return MyService(
///       param1: params['param1'],
///     );
///   },
/// );
/// ```
///
/// This example demonstrates how to use the [FutureParamFactoryService] to create
/// and manage an instance of `MyService`.
///
/// - [T]: The type of the instance managed by this service.
class FutureParamFactoryService<T> extends Service<T> {
  /// Creates a [AsyncFactoryService] with the given [create] callback.
  ///
  /// The [create] callback is required and defines how the instance of type [T]
  /// is created.
  FutureParamFactoryService({required this.create});

  /// The callback that defines how the instance of type [T] is created.
  final FutureParamServiceCreator<T> create;
}
