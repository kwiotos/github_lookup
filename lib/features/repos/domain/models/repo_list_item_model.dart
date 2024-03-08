import 'package:equatable/equatable.dart';

import 'repo_owner_model.dart';

class RepoListItemModel extends Equatable {
  final int id;
  final String name;
  final RepoOwnerModel owner;

  const RepoListItemModel({
    required this.id,
    required this.name,
    required this.owner,
  });

  @override
  List<Object?> get props => [id, name, owner];
}
