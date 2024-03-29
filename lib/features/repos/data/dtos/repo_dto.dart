import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_list_item_model.dart';
import 'user_dto.dart';

part 'repo_dto.g.dart';

@JsonSerializable()
class RepoDto extends Equatable {
  final int id;
  final String name;
  final UserDto owner;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String? description;

  const RepoDto(
    this.id,
    this.name,
    this.owner,
    this.fullName,
    this.description,
  );

  @override
  List<Object?> get props => [id, name, owner, fullName, description];

  factory RepoDto.fromJson(Map<String, dynamic> json) =>
      _$RepoDtoFromJson(json);

  RepoListItemModel toListModel() => RepoListItemModel(
        id: id,
        name: name,
        owner: owner.toModel(),
        fullName: fullName,
        description: description,
      );
}
