import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:niagara_app/core/core.dart';

abstract class INetworkInfo {
  Future<bool> get hasConnection;
}

@LazySingleton(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  const NetworkInfo(this.connectionChecker);
  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get hasConnection => connectionChecker.hasConnection;
}
