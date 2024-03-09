import 'package:equatable/equatable.dart';

import 'user_model.dart';

class RepoListItemModel extends Equatable {
  final int id;
  final String name;
  final UserModel owner;

  const RepoListItemModel({
    required this.id,
    required this.name,
    required this.owner,
  });

  @override
  List<Object?> get props => [id, name, owner];
}
