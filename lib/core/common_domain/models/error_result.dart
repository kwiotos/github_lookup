import 'package:equatable/equatable.dart';

class ErrorResult extends Equatable {
  const ErrorResult({this.statusCode, this.message});

  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => <Object?>[statusCode, message];
}
