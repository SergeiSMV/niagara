import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';

class DeliveryTimeOptions extends Equatable {
  const DeliveryTimeOptions({
    required this.date,
    required this.timeSlots,
  });

  final DateTime date;
  final List<TimeSlot> timeSlots;

  @override
  List<Object?> get props => [date, timeSlots];
}
