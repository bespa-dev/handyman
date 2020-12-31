import 'package:lite/domain/models/models.dart';

abstract class BaseAuthRepository implements Exposable {
  Future<void> signOut();
}
