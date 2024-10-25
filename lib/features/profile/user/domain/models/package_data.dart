import 'package:niagara_app/core/core.dart';

class PackageData extends Equatable {
  const PackageData(
    this.version,
    this.buildNumber,
  );

  final String version;
  final String buildNumber;

  String get fullVersion => '$version ($buildNumber)';

  @override
  List<Object> get props => [
        version,
        buildNumber,
      ];
}
