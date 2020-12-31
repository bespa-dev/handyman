import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:handyman/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: ProApp()));
}
