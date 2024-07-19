import 'package:example/app_config.dart';
import 'package:injector/injector.dart';

final inject = Injector.inject;

abstract class AppDependencies {
  static void init() {
    inject.addSingleton<AppConfig>(AppConfig());
  }
}
