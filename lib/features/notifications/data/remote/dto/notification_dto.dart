// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';

part 'notification_dto.g.dart';

typedef NotificationsDto = ({
  List<NotificationDto> notifications,
  PaginationDto pagination,
});

@JsonSerializable(createToJson: false)
class NotificationDto extends Equatable {
  const NotificationDto({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    required this.link,
    required this.image,
    required this.isNew,
  });

  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'DATA')
  final DateTime date;
  @JsonKey(name: 'TITLE')
  final String title;
  @JsonKey(name: 'DESCRIPTION')
  final String description;
  @JsonKey(name: 'ICON')
  final String icon;
  @JsonKey(name: 'TYPE')
  final String type;
  @JsonKey(name: 'LINK')
  final String link;
  @JsonKey(name: 'IMAGE')
  final String image;
  @JsonKey(name: 'NEW')
  final bool isNew;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  @override
  List<Object?> get props => [
        id,
        date,
        title,
        description,
        icon,
        type,
        link,
        image,
        isNew,
      ];
}
