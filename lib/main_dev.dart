import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/main.dart' as regular;

Future<void> main() async {
  AppConstants.kShowDebugButton = true;

  regular.main();
}
