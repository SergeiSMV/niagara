import 'package:equatable/equatable.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/_common/domain/models/base_locality.dart';

class Shop extends BaseLocality {
  const Shop({
    required super.id,
    required super.coordinates,
    required super.province,
    required super.locality,
    required int storeDays,
    required String openTime,
    required String closeTime,
    required List<ShopSchedule> schedule,
  })  : _storeDays = storeDays,
        _openTime = openTime,
        _closeTime = closeTime,
        _schedule = schedule;

  final int _storeDays;
  final String _openTime;
  final String _closeTime;
  final List<ShopSchedule> _schedule;

  @override
  String get name => super.locality;

  String get description => _everydaySchedule;

  String get schedule => _isSameSchedule
      ? _everydaySchedule
      : '$_weekdaysSchedule \n$_weekendSchedule';

  String get _everydaySchedule => t.shops.workTime(
        startTime: _openTime,
        endTime: _closeTime,
      );

  String get _weekdaysSchedule => t.shops.worksDaysWorkTime(
        startTime: _weekdaysWorkTime.first.$1,
        endTime: _weekdaysWorkTime.first.$2,
      );

  String get _weekendSchedule => t.shops.weekendDaysWorkTime(
        startTime: _weekendsWorkTime.first.$1,
        endTime: _weekendsWorkTime.first.$2,
      );

  bool get _isSameSchedule => _weekdaysWorkTime.containsAll(_weekendsWorkTime);

  Set<(String, String)> get _weekdaysWorkTime => _schedule
      .where((item) => item.day >= 1 && item.day <= 5)
      .map((item) => (item.openTime, item.closeTime))
      .toSet();

  Set<(String, String)> get _weekendsWorkTime => _schedule
      .where((item) => item.day >= 6 && item.day <= 7)
      .map((item) => (item.openTime, item.closeTime))
      .toSet();

  @override
  List<Object?> get props => [
        super.id,
        super.coordinates,
        super.province,
        super.locality,
        _storeDays,
        _openTime,
        _closeTime,
        _schedule,
      ];
}

class ShopSchedule extends Equatable {
  const ShopSchedule({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  final int day;
  final String openTime;
  final String closeTime;

  @override
  List<Object?> get props => [
        day,
        openTime,
        closeTime,
      ];
}
