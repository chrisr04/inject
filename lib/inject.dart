library inject;

import 'dart:async';
import 'package:inject/types/types.dart';
import 'package:inject/services/services.dart';

part 'service_locator/service_locator.dart';
part 'service_locator/service_locator_impl.dart';
part 'service_locator/service_resolver.dart';

/// The `Inject` class provides a `ServiceLocator` implementation.
/// That locator provides methods for registering and retrieving various types of services,
/// including singletons, asynchronous singletons, lazy singletons, factories, and asynchronous factories.
/// It also includes methods for disposing of services and clearing all registrations.
abstract class Inject {
  /// The static instance of the `ServiceLocator` implementation.
  static final instance = _ServiceLocatorImpl();
}
