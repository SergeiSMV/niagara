import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';

abstract interface class IBannersRepository {
  Future<Either<Failure, List<Banner>>> getBanners();
}
