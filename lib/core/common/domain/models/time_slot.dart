import 'package:niagara_app/core/core.dart';

class TimeSlot extends Equatable {
  const TimeSlot({
    required this.timeBegin,
    required this.timeEnd,
  });

  final String timeBegin;
  final String timeEnd;

  @override
  List<Object?> get props => [
        timeBegin,
        timeEnd,
      ];
}
