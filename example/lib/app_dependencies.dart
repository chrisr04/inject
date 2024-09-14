import 'package:example/app_config.dart';
import 'package:inject/inject.dart';

final inject = Inject.instance;

abstract class AppDependencies {
  static void init() {
    inject.addSingleton<AppConfig>(AppConfig());
  }
}
