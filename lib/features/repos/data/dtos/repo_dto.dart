import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repo_list_item_model.dart';
import '../../domain/models/repos_list_model.dart';

part 'repo_dto.g.dart';

@JsonSerializable()
class RepoDto extends Equatable {
  final int id;
  final String name;

  const RepoDto(this.id, this.name);

  @override
  List<Object?> get props => [id, name];

  factory RepoDto.fromJson(Map<String, dynamic> json) =>
      _$RepoDtoFromJson(json);

  RepoListItemModel toListModel() => RepoListItemModel(id: id, name: name);
}
