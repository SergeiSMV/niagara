// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';

typedef ReferralHistoryDto = ({
  List<ReferralHistoryItemDto> history,
  PaginationDto pagination,
});

class ReferralHistoryItemDto extends Equatable {
  final DateTime friendDate;
  final String friendPhone;
  final String friendName;
  final int friendCount;

  @override
  List<Object?> get props => [
        friendDate,
        friendPhone,
        friendName,
        friendCount,
      ];

  const ReferralHistoryItemDto({
    required this.friendDate,
    required this.friendPhone,
    required this.friendName,
    required this.friendCount,
  });

  factory ReferralHistoryItemDto.fromJson(Map<String, dynamic> json) =>
      ReferralHistoryItemDto(
        friendDate: DateTime.parse(json['FRIEND_DATE'] as String),
        friendPhone: json['FRIEND_PHONE'] as String,
        friendName: json['FRIEND_NAME'] as String,
        friendCount: (json['FRIEND_COUNT'] as num).toInt(),
      );
}
