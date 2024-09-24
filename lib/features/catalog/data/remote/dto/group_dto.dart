// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'group_dto.g.dart';

@JsonSerializable(createToJson: false)
class GroupDto extends Equatable {
  const GroupDto({
    this.group,
    this.groupId,
    this.image,
  });

  @JsonKey(name: 'GROUP')
  final String? group;
  @JsonKey(name: 'GROUP_ID')
  final String? groupId;
  @JsonKey(name: 'IMAGE')
  final String? image;

  factory GroupDto.fromJson(Map<String, dynamic> json) =>
      _$GroupDtoFromJson(json);

  @override
  List<Object?> get props => [group, groupId, image];
}
