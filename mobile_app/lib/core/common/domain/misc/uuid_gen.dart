import 'package:uuid/uuid.dart';

abstract class UUIDGen {
  String generate();
}

class UUidGenImpl implements UUIDGen {
  @override
  String generate() {
    return const Uuid().v4();
  }
}
