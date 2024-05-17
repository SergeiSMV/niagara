import 'package:niagara_app/core/common/domain/models/pagination.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonus_history.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';

typedef BonusesHistory = ({List<BonusHistory> history, Pagination pagination});

abstract interface class IBonusesRepository {
  Future<Either<Failure, Bonuses>> getBonuses();

  Future<Either<Failure, BonusesHistory>> getHistory({required int page});
}
