library injector;

import 'dart:async';
import 'package:injector/types/types.dart';
import 'package:injector/services/services.dart';

part 'service_locator/service_locator.dart';
part 'service_locator/service_locator_impl.dart';
part 'service_locator/service_resolver.dart';

/// The `Injector` class provides a `ServiceLocator` implementation.
/// That locator provides methods for registering and retrieving various types of services,
/// including singletons, asynchronous singletons, lazy singletons, factories, and asynchronous factories.
/// It also includes methods for disposing of services and clearing all registrations.
abstract class Injector {
  /// The static instance of the `ServiceLocator` implementation.
  static final inject = _ServiceLocatorImpl();
}
