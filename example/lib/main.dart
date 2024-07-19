import 'package:example/app_config.dart';
import 'package:example/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  AppDependencies.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = inject<AppConfig>();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('AppVersion: ${appConfig.version}'),
        ),
      ),
    );
  }
}
