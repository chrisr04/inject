import 'dart:async';

/// A type definition for a function that creates a service of type [T].
typedef ServiceCreator<T> = T Function();

/// A type definition for a function that creates a service of type [T] with specific params.
typedef ParamServiceCreator<T> = T Function(Map<String, dynamic>);

/// A type definition for a function that asynchronously creates a service of type [T].
typedef AsyncServiceCreator<T> = Future<T> Function();

/// A type definition for a function that disposes a service of type [T].
typedef ServiceDisposer<T> = void Function(T);
