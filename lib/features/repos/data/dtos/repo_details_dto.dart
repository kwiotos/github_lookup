import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_details_model.dart';
import '../../domain/models/repo_list_item_model.dart';
import '../../domain/models/repos_list_model.dart';
import 'repo_owner_dto.dart';

part 'repo_details_dto.g.dart';

@JsonSerializable()
class RepoDetailsDto extends Equatable {
  final int id;
  final String name;
  final RepoOwnerDto owner;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? description;
  final String? language;
  final List<String> topics;
  final int? forks;
  @JsonKey(name: 'stargazers_count')
  final int? stars;
  @JsonKey(name: 'subscribers_count')
  final int? subscribers;

  const RepoDetailsDto({
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
  List<Object?> get props =>
      [
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

  factory RepoDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$RepoDetailsDtoFromJson(json);

  RepoDetailsModel toModel() =>
      RepoDetailsModel(
        id: id,
        name: name,
        owner: owner.toModel(),
        fullName: fullName,
        description: description,
        language: language,
        topics: topics,
        forks: forks,
        stars: stars,
        subscribers: subscribers,
      );
}
