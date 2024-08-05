import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';

class Equipment extends Equatable {
  const Equipment({
    required this.locationId,
    required this.locationName,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.serviceLastDate,
    required this.serviceNextDate,
    required this.serviceDaysLeft,
    required this.orderDate,
    required this.orderTimeBegin,
    required this.orderTimeEnd,
  });

  final String locationId;
  final String locationName;
  final int id;
  final String name;
  final String imageUrl;
  final CleaningStatuses status;
  final DateTime serviceLastDate;
  final DateTime serviceNextDate;
  final int serviceDaysLeft;
  final DateTime orderDate;
  final DateTime orderTimeBegin;
  final DateTime orderTimeEnd;

  @override
  List<Object?> get props => [
        locationId,
        locationName,
        id,
        name,
        imageUrl,
        status,
        serviceLastDate,
        serviceNextDate,
        serviceDaysLeft,
        orderDate,
        orderTimeBegin,
        orderTimeEnd,
      ];
}
