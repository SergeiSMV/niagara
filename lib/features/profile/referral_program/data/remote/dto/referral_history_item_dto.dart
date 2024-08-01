// ignore_for_file: sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
import 'package:niagara_app/core/core.dart';

part 'referral_history_item_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.screamingSnake, createToJson: false)
class ReferralHistoryItemDto extends Equatable {
  final String friendDate;
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
      _$ReferralHistoryItemDtoFromJson(json);
}
