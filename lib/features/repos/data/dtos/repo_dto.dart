import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_list_item_model.dart';
import 'repo_owner_dto.dart';

part 'repo_dto.g.dart';

@JsonSerializable()
class RepoDto extends Equatable {
  final int id;
  final String name;
  final RepoOwnerDto owner;

  const RepoDto(this.id, this.name, this.owner);

  @override
  List<Object?> get props => [id, name, owner];

  factory RepoDto.fromJson(Map<String, dynamic> json) =>
      _$RepoDtoFromJson(json);

  RepoListItemModel toListModel() => RepoListItemModel(
        id: id,
        name: name,
        owner: owner.toModel(),
      );
}
