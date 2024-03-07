import '../common_domain/models/api_result.dart';
import '../common_domain/models/error_result.dart';

extension FutureResponseExtension on Future<dynamic> {
  Future<ApiResult<T>> handleResponse<T>(Function(dynamic) parse) async {
    try {
      final response = await this;

      return ApiResult.success(data: parse(response));
    } on Exception catch (e, stackTrace) {
      return ApiResult.failure(
        errorResult: const ErrorResult(),
        stackTrace: stackTrace,
      );
    }
  }
}
