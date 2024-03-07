import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/repos_list_model.dart';
import 'repo_dto.dart';

part 'get_repos_result_dto.g.dart';

@JsonSerializable()
class GetReposResultDto extends Equatable {
  @JsonKey(name: 'total_count')
  final int totalCount;
  final List<RepoDto> items;

  const GetReposResultDto(this.totalCount, this.items);

  @override
  List<Object?> get props => [totalCount, items];

  factory GetReposResultDto.fromJson(Map<String, dynamic> json) =>
      _$GetReposResultDtoFromJson(json);

  ReposListModel toModel() => ReposListModel(
        totalCount: totalCount,
        items: items.map((e) => e.toListModel()).toList(),
      );
}
