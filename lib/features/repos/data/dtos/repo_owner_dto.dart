import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_list_item_model.dart';
import '../../domain/models/repo_owner_model.dart';
import '../../domain/models/repos_list_model.dart';

part 'repo_owner_dto.g.dart';

@JsonSerializable()
class RepoOwnerDto extends Equatable {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  const RepoOwnerDto({required this.id, required this.login, this.avatarUrl});

  @override
  List<Object?> get props => [id, login, avatarUrl];

  factory RepoOwnerDto.fromJson(Map<String, dynamic> json) =>
      _$RepoOwnerDtoFromJson(json);

  RepoOwnerModel toModel() => RepoOwnerModel(
        id: id,
        login: login,
        avatarUrl: avatarUrl,
      );
}
