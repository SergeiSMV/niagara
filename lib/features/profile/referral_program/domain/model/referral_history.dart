import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';

typedef ReferralHistory = ({
  List<ReferralHistoryItem> history,
  Pagination pagination,
});

class ReferralHistoryItem extends Equatable {
  const ReferralHistoryItem({
    required this.friendDate,
    required this.friendPhone,
    required this.friendName,
    required this.friendCount,
  });

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
}
