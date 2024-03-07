import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_result.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({
    required ErrorResult errorResult,
    required StackTrace stackTrace,
  }) = Failure<T>;
}
