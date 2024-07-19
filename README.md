# Injector

This package provides a powerful and flexible service locator for Flutter projects, allowing for the registration and retrieval of various types of services, including singletons, asynchronous singletons, lazy singletons, factories, and asynchronous factories. It includes methods for disposing of services and clearing all registrations, making it easy to manage dependencies in your application.

## Features

- Register and retrieve singleton instances
- Support for asynchronous singletons
- Lazy singletons for on-demand instantiation
- Factory methods for creating new instances on each request
- Asynchronous factories for creating instances with asynchronous initialization
- Dispose and clear services with ease

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  injector:
    git:
      url: https://github.com/chrisr04/injector
      ref: v0.0.1
```

## Usage
At your start-up you can add all the objects you want to access later like this:

```dart
final inject = Injector.inject;

void appDependencies(){
  inject.addSingleton<MyService>(MyService());
}
```

### Synchronous Singleton
You can add a synchronous singleton using the following method:
```dart
inject.addSingleton<MyService>(MyService());
```
### Asynchronous Singleton
You can add an asynchronous singleton using the following method:
```dart
inject.addAsyncSingleton<MyService>(() async => MyService());
```

### Asynchronous Singleton
You can add a lazy singleton using the following method:
```dart
inject.addLazySingleton<MyService>(() => MyService());
```
The instance will be created only when `inject<MyService>()` is called.

### Synchronous Factory
You can add a synchronous factory using the following method:
```dart
inject.addFactory<MyService>(() => MyService());
```
A new instance will be created when `inject<MyService>()` is called.

### Asynchronous Factory
You can add an asynchronous factory using the following method:

```dart
inject.addAsyncFactory<MyService>(() async => MyService());
```

### Factory with params
You can add a factory with dynamic params using the following method:

```dart
inject.addFactoryWithParams<MyService>(
  (params) => MyService(
    id: params['id'] as int,
    token: params['token'] as String,
  ),
);
```

### Synchronous Retrieval

```dart
final myService = inject<MyService>();
```

### Asynchronous Retrieval
For Singletons:

```dart
await inject.resolveAsync();
final myService = inject<MyService>();
```

**Note:** The `resolveAsync()` method resolves all asynchronous singletons you have added so far.

For factories:

```dart
final myService = await inject.getAsync<MyService>();
```

### Parameters Retrieval
```dart
final myService = inject.getWithParams<MyService>(
  params: {
    'id': 34773,
    'token': 'Yzs2st9bAK0bA1r',
  }
);
```

### Disposing Instances
If you want to remove a service you can use the `dispose<MyService>()` method, this will delete the instance and call the `onDispose` method associated.

```dart
inject.addSingleton<MyService>(
  MyService(),
  onDispose: (service) => service.dispose(),
);

inject.dispose<MyService>();
```

### Named Instances
If you need to add more than one instance of the same type, you can use the `name` property that most methods have:

```dart
inject.addSingleton<MyService>(
  MyService(), 
  name: 'myService1',
);

inject.addSingleton<MyService>(
  MyService(), 
  name: 'myService2',
);

final myService1 = inject<MyService>(name: 'myService1');
final myService2 = inject<MyService>(name: 'myService2');

inject.dispose<MyService>(name: 'myService1');
inject.dispose<MyService>(name: 'myService2');
```

### Clear
If you want to remove all services you can use the clear() method. this will delete all the instances and call the `onDispose` for each service.

```dart
inject.clear();
```
