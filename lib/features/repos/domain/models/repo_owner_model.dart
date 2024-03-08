import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_list_item_model.dart';
import '../../domain/models/repos_list_model.dart';

class RepoOwnerModel extends Equatable {
  final int id;
  final String login;
  final String? avatarUrl;

  const RepoOwnerModel({required this.id, required this.login, this.avatarUrl});

  @override
  List<Object?> get props => [id, login, avatarUrl];
}
