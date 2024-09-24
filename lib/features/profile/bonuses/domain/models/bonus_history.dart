import 'package:niagara_app/core/core.dart';

class BonusHistory extends Equatable {
  const BonusHistory({
    required this.date,
    required this.value,
    required this.info,
    required this.isTemp,
  });

  final DateTime date;
  final double value;
  final String info;
  final bool isTemp;

  @override
  List<Object?> get props => [date, value, info, isTemp];
}
