import 'package:niagara_app/core/core.dart';

@Equatable()
class BonusHistory {
  BonusHistory({
    required this.date,
    required this.value,
    required this.info,
    required this.isTemp,
  });

  final DateTime date;
  final int value;
  final String info;
  final bool isTemp;
}
