import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';

class DeliveryTimeOptions extends Equatable {
  DeliveryTimeOptions({
    required this.date,
    required List<TimeSlot> timeSlots,
  }) : timeSlots = timeSlots.map(_convertFormat).toList();

  final DateTime date;
  final List<TimeSlot> timeSlots;

  @override
  List<Object?> get props => [date, timeSlots];
}

TimeSlot _convertFormat(TimeSlot original) {
  final DateTime? begin = DateTime.tryParse(original.timeBegin);
  final DateTime? end = DateTime.tryParse(original.timeEnd);

  final formatter = DateFormat('HH:mm');

  return TimeSlot(
    timeBegin: begin != null ? formatter.format(begin) : original.timeBegin,
    timeEnd: end != null ? formatter.format(end) : original.timeEnd,
  );
}

class TestDeliveryTimeOptions extends Equatable {
  const TestDeliveryTimeOptions({
    required this.dates,
    required this.slots,
  });

  final List<DateTime> dates;
  final Map<DateTime, List<TimeSlot>> slots;

  @override
  List<Object?> get props => [];
}
