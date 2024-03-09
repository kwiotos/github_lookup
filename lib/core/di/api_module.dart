import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../config/app_config.dart';
import '../config/app_constants.dart';

@module
abstract class ApiModule {
  @Named(githubApiBaseUrlKey)
  String githubApiBaseUrl(AppConfig config) => config.baseUrl;

  @lazySingleton
  Dio dio(AppConfig config) {
    final Dio dio = Dio();
    dio.options.headers = config.headers;
    return dio;
  }
}
