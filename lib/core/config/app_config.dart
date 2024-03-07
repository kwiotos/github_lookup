import 'package:injectable/injectable.dart';

import 'app_constants.dart';

@injectable
class AppConfig {
  String get baseUrl => githubApiUrl;

  Map<String, String> get headers => {};
}