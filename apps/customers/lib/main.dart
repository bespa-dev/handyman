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
import 'package:lite/app/app.dart';
import 'package:lite/shared/shared.dart';

/// This mobile app was developed using the The Flutter Clean Architecture
/// Read more -> https://pub.dev/documentation/flutter_clean_architecture/latest/
///
/// Fix for release build error
/// https://stackoverflow.com/questions/63766058/flutter-issues-with-release-mode-only-apk-builds
/// flutter pub run flutter_launcher_icons:main --verbose
/// flutter pub run flutter_launcher_name:main --verbose
/// flutter analyze .


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize all dependencies
  await initAppDependencies();

  runApp(ProviderScope(child: HandyManApp()));
}
