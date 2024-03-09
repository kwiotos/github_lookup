import 'package:equatable/equatable.dart';

import 'user_model.dart';

class PullModel extends Equatable {
  final int id;
  final int number;
  final String title;
  final UserModel user;
  final DateTime createdAt;

  const PullModel({
    required this.id,
    required this.number,
    required this.title,
    required this.user,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, number, title, user, createdAt];
}
