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
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

import 'data/entities/src/business/business.dart';

/// This mobile app was developed using the The Flutter Clean Architecture
/// Read more -> https://pub.dev/documentation/flutter_clean_architecture/latest/
///
/// Fix for release build error
/// https://stackoverflow.com/questions/63766058/flutter-issues-with-release-mode-only-apk-builds
/// flutter pub run flutter_launcher_icons:main
/// flutter pub run flutter_launcher_name:main
/// flutter packages pub run build_runner watch --delete-conflicting-outputs --verbose
/// flutter packages pub run build_runner build --delete-conflicting-outputs --verbose
/// Flutter channel used -> dev
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize all dependencies
  await initAppDependencies();

  runApp(ProviderScope(child: HandyManApp()));
}

final kSampleBusiness = Business(
  id: Uuid().v4(),
  createdAt: DateTime.now().toIso8601String(),
  docUrl: '',
  artisanId: '123456',
  name: 'Bad business',
  location: 'Dansoman',
);

final kSampleArtisan = Artisan(
  id: Uuid().v4(),
  createdAt: DateTime.now().toIso8601String(),
  startWorkingHours: DateTime.now().toIso8601String(),
  endWorkingHours: DateTime.now().toIso8601String(),
  name: 'Quabynah',
  token: null,
  phone: '+233554635701',
  avatar: '',
  email: 'codelbas.quabynah@gmail.com',
  services: [

  ],
);
