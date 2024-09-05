import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';

/// Описывает возможные дату доставки и список временных интервалов, доступных
/// для выбора в этот день.
class DeliveryTimeOptions extends Equatable {
  DeliveryTimeOptions({
    required this.date,
    required List<TimeSlot> timeSlots,
  }) : timeSlots = timeSlots.map(_convertFormat).toList();

  /// Дата, на которую доступны временные интервалы.
  ///
  /// Должна учитываться только дата, время не несёт смысловой нагрузки.
  final DateTime date;

  /// Временные интервалы, доступные для выбора в день [date].
  final List<TimeSlot> timeSlots;

  @override
  List<Object?> get props => [date, timeSlots];
}

/// Преобразует формат времени из [TimeSlot] в формат, удобный для отображения.
///
/// Обычно с бекенда [TimeSlot] приходит в формате `0001-01-01T00:00:00`, но
/// смысл имеют только часы и минуты.
TimeSlot _convertFormat(TimeSlot original) {
  final DateTime? begin = DateTime.tryParse(original.timeBegin);
  final DateTime? end = DateTime.tryParse(original.timeEnd);

  final formatter = DateFormat('HH:mm');

  return TimeSlot(
    timeBegin: begin != null ? formatter.format(begin) : original.timeBegin,
    timeEnd: end != null ? formatter.format(end) : original.timeEnd,
  );
}
