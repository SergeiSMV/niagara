import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';

/// Описывает возможные дату доставки и список временных интервалов, доступных
/// для выбора в этот день.
class DeliveryTimeOptions extends Equatable {
  const DeliveryTimeOptions({
    required this.date,
    required this.timeSlots,
  });

  /// Дата, на которую доступны временные интервалы.
  ///
  /// Должна учитываться только дата, время не несёт смысловой нагрузки.
  final DateTime date;

  /// Временные интервалы, доступные для выбора в день [date].
  final List<TimeSlot> timeSlots;

  @override
  List<Object?> get props => [date, timeSlots];
}
