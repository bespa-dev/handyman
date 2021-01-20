/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:handyman/app/app.dart';
import 'package:handyman/shared/shared.dart';

/// This mobile app was developed using the The Flutter Clean Architecture
/// Read more -> https://pub.dev/documentation/flutter_clean_architecture/latest/
///
/// Fix for release build error
/// https://stackoverflow.com/questions/63766058/flutter-issues-with-release-mode-only-apk-builds
/// flutter pub run flutter_launcher_icons:main
/// flutter pub run flutter_launcher_name:main
/// flutter packages pub run build_runner watch --delete-conflicting-outputs --verbose
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize all dependencies
  await initAppDependencies();

  runApp(ProviderScope(child: HandyManApp()));
}
