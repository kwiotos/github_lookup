import 'package:dio/dio.dart';
import 'package:github_lookup/core/config/app_config.dart';
import 'package:github_lookup/core/config/app_constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ApiModule {
  @Named(githubApiBaseUrlKey)
  String githubApiBaseUrl(AppConfig config) => config.baseUrl;

  @lazySingleton
  Dio dio(AppConfig config) {
    Dio dio = Dio();
    dio.options.headers = config.headers;
    return dio;
  }
}