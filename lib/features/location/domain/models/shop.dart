import 'package:equatable/equatable.dart';
import 'package:niagara_app/features/location/domain/models/base_locality.dart';

class Shop extends BaseLocality {
  const Shop({
    required List<ShopWorkTime> workTime,
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
  }) : _workTime = workTime;

  final List<ShopWorkTime> _workTime;

  @override
  String get name => super.locality;

  @override
  List<Object?> get props => [
        super.id,
        super.coordinates,
        super.province,
        super.locality,
        _workTime,
      ];
}

class ShopWorkTime extends Equatable {
  const ShopWorkTime({
    required this.day,
    required this.timeStart,
    required this.timeEnd,
  });

  final int day;
  final String timeStart;
  final String timeEnd;

  @override
  List<Object?> get props => [
        day,
        timeStart,
        timeEnd,
      ];
}
