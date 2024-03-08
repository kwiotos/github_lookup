import 'package:equatable/equatable.dart';

import 'repo_owner_model.dart';

class RepoDetailsModel extends Equatable {
  final int id;
  final String name;
  final RepoOwnerModel owner;
  final String? fullName;
  final String? description;
  final String? language;
  final List<String> topics;
  final int? forks;
  final int? stars;
  final int? subscribers;

  const RepoDetailsModel({
    required this.id,
    required this.name,
    required this.owner,
    this.fullName,
    this.description,
    this.language,
    this.topics = const [],
    this.forks,
    this.stars,
    this.subscribers,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        owner,
        fullName,
        description,
        language,
        topics,
        forks,
        stars,
        subscribers,
      ];
}
