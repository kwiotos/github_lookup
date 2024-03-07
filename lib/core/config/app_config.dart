import 'package:injectable/injectable.dart';

import 'app_constants.dart';

@injectable
class AppConfig {
  String get baseUrl => githubApiBaseUrlKey;

  Map<String, String> get headers => {};
}