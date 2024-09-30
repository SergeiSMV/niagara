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
        friendDate: DateTime.parse(json['DATE'] as String),
        friendPhone: json['PHONE'] as String,
        friendName: json['NAME'] as String,
        friendCount: (json['COUNT'] as num).toInt(),
      );
}
