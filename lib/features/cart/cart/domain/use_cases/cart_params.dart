import 'package:niagara_app/core/core.dart';

class CartParams extends Equatable {
  const CartParams({
    required this.locationId,
    required this.bonuses,
    required this.promocode,
    required this.tareCount,
    required this.allTare,
  });

  final String locationId;
  final int bonuses;
  final String promocode;
  final int tareCount;
  final bool allTare;

  @override
  List<Object?> get props => [
        locationId,
        bonuses,
        promocode,
        tareCount,
        allTare,
      ];
}
