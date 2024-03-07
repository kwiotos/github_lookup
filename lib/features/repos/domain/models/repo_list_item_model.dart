import 'package:equatable/equatable.dart';

class RepoListItemModel extends Equatable {
  final int id;
  final String name;

  const RepoListItemModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
