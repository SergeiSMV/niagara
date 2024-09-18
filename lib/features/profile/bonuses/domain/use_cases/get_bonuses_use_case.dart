import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/repositories/bonuses_repository.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@injectable
class GetBonusesUseCase extends BaseUseCase<Bonuses, bool> {
  GetBonusesUseCase(this._bonusesRepository, this._profileRepository);

  final IBonusesRepository _bonusesRepository;

  final IProfileRepository _profileRepository;

  /// Получаетс данные о бонусах пользователя.
  ///
  /// Если указан [getRemote], равный `true`, то данные о пользователе будут
  /// повторно запрошены с сервера.
  ///
  /// Без [getRemote] данные будут взяты из локального источника и могут быть
  /// неактуальны.
  @override
  Future<Either<Failure, Bonuses>> call([bool getRemote = false]) async {
    if (getRemote) {
      await _profileRepository.getUser();
    }

    return _bonusesRepository.getBonuses();
  }
}
