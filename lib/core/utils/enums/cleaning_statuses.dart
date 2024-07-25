import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum CleaningStatuses {
  no,
  cleaningIsRequired,
  cleaningIsExpected;

  String toLocale() => switch (this) {
        no => '',
        cleaningIsRequired => t.equipments.cleaningStatuses.cleaningIsRequired,
        cleaningIsExpected => t.equipments.cleaningStatuses.cleaningIsExpected,
      };
}
