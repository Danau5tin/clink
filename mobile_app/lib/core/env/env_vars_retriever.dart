import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvVarsRetriever {
  Future<void> init();

  String? getEnvVar(String key);
}

class EnvVarsRetrieverImpl implements EnvVarsRetriever {
  @override
  Future<void> init() async {
    await dotenv.load();
  }

  @override
  String? getEnvVar(String key) {
    return dotenv.env[key];
  }
}
