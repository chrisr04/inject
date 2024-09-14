import 'package:inject/types/types.dart';
import 'package:inject/services/service.dart';

/// A service that creates instances of type [T] asynchronously.
///
/// The `AsyncFactoryService` class is a specialized service that uses an asynchronous
/// function to create instances of type [T]. It extends the `Service` class and adds
/// functionality to support asynchronous initialization.
///
/// The `create` parameter is required and should be an instance of [AsyncServiceCreator<T>]
/// that defines the asynchronous creation logic.
///
/// Example:
/// ```dart
/// AsyncFactoryService<MyService>(
///   create: () async {
///     // Perform async operations to initialize MyService
///     return MyService();
///   },
/// );
/// ```
///
/// [T] - The type of the service being created.
class AsyncFactoryService<T> extends Service<T> {
  /// Creates an instance of `AsyncFactoryService`.
  ///
  /// The `create` function is required and should contain the logic for asynchronously
  /// creating an instance of type [T].
  AsyncFactoryService({required this.create});

  /// The asynchronous function that creates an instance of type [T].
  final AsyncServiceCreator<T> create;
}
