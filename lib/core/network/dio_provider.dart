import 'package:dio/dio.dart';
import 'package:github_lookup/core/config/app_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioProvider {
  @singleton
  Dio dio(AppConfig config) {
    Dio dio = Dio();
    dio.options.headers = config.headers;
    return dio;
  }
}