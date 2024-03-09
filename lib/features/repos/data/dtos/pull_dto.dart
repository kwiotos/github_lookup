import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/pull_model.dart';
import 'user_dto.dart';

part 'pull_dto.g.dart';

@JsonSerializable()
class PullDto extends Equatable {
  final int id;
  final int number;
  final String title;
  final UserDto user;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const PullDto(
    this.id,
    this.number,
    this.title,
    this.user,
    this.createdAt,
  );

  @override
  List<Object?> get props => [id, number, title, user, createdAt];

  factory PullDto.fromJson(Map<String, dynamic> json) =>
      _$PullDtoFromJson(json);

  PullModel toModel() => PullModel(
        id: id,
        number: number,
        title: title,
        user: user.toModel(),
        createdAt: DateTime.parse(createdAt),
      );
}
