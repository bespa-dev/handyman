import 'package:flutter_test/flutter_test.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:uuid/uuid.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final prefsProvider = await PrefsProvider.get();

  test("Test prefs provider", () async {
    final uid = Uuid().v4();
    prefsProvider.saveUserId(uid);
    expect(uid, prefsProvider.userId);

    await Future.delayed(kSheetDuration);
    await prefsProvider.clearUserData();
    expect(null, prefsProvider.userId);
  });
}
