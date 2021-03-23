import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('get services', () async {
    var serviceSource = await rootBundle.loadString('assets/services.json');
    var decodedServices = jsonDecode(serviceSource) as List;
    for (var json in decodedServices) {
      final item = ArtisanService.fromJson(json);
      if(item.category == '8ecf642d-429f-4b51-805b-0678a9af8e28') {
        logger.i(item);
      }
    }
  });

  test('gen ids', () {
    for (var i = 0; i < 20; i++) {
      final timestamp = DateTime.now().toIso8601String();
      logger.i('${Uuid().v4()} => $timestamp');
    }
  });
}
