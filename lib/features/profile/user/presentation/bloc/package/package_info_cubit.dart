import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';

@injectable
class PackageDataCubit extends Cubit<PackageData?> {
  PackageDataCubit() : super(null) {
    _init();
  }

  Future<void> _init() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(PackageData(packageInfo.version, packageInfo.buildNumber));
  }
}

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
