import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:lite/app/app.dart';
import 'package:lite/shared/shared.dart';

/// This mobile app was developed using the The Flutter Clean Architecture
/// Read more -> https://pub.dev/documentation/flutter_clean_architecture/latest/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // register SDKs
  await registerSDKs();

  runApp(ProviderScope(child: LiteApp()));
}
