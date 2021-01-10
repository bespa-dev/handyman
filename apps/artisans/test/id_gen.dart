import 'package:flutter_test/flutter_test.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("gen ids", () {
    for (int i = 0; i < 20; i++) {
      final timestamp = DateTime.now().toIso8601String();
      logger.i("${Uuid().v4()} => $timestamp");
    }
  });
}
