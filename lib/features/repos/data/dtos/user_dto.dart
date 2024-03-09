import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/user_model.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  final int id;
  final String login;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  const UserDto({required this.id, required this.login, this.avatarUrl});

  @override
  List<Object?> get props => [id, login, avatarUrl];

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  UserModel toModel() => UserModel(
        id: id,
        login: login,
        avatarUrl: avatarUrl,
      );
}
