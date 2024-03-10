import 'package:equatable/equatable.dart';

import 'user_model.dart';

class RepoListItemModel extends Equatable {
  final int id;
  final String name;
  final UserModel owner;
  final String fullName;
  final String? description;

  const RepoListItemModel({
    required this.id,
    required this.name,
    required this.owner,
    required this.fullName,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, owner, fullName, description];
}
