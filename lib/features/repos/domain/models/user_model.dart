import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String login;
  final String? avatarUrl;

  const UserModel({required this.id, required this.login, this.avatarUrl});

  @override
  List<Object?> get props => [id, login, avatarUrl];
}
