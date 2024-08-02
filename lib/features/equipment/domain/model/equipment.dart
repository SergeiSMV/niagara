import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';

class Equipment extends Equatable {
  const Equipment({
    required this.locationId,
    required this.locationName,
    required this.id,
    required this.name,
    required this.status,
    required this.serviceLastDate,
    required this.serviceNextDate,
    required this.serviceDaysLeft,
  });

  final String locationId;
  final String locationName;
  final int id;
  final String name;
  final CleaningStatuses status;
  final DateTime serviceLastDate;
  final DateTime serviceNextDate;
  final int serviceDaysLeft;

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        id,
        name,
        status,
        serviceLastDate,
        serviceNextDate,
        serviceDaysLeft,
      ];
}
