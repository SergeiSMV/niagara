import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

abstract interface class IBonusesRepository {
  Future<Either<Failure, Bonuses>> getBonuses();
}
