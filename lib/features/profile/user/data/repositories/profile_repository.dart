import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_dto_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/user/data/local/data_source/user_local_data_source.dart';

import 'package:niagara_app/features/profile/user/data/mappers/user_dto_mapper.dart';
import 'package:niagara_app/features/profile/user/data/mappers/user_entity_mapper.dart';
import 'package:niagara_app/features/profile/user/data/remote/data_source/profile_remote_data_source.dart';
import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/domain/repositories/profile_repository.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository extends BaseRepository implements IProfileRepository {
  ProfileRepository(
    super._logger,
    super._networkInfo,
    this._userLDS,
    this._bonusesLDS,
    this._profileRDS,
  );

  final IUserLocalDataSource _userLDS;
  final IBonusesLocalDataSource _bonusesLDS;
  final IProfileRemoteDataSource _profileRDS;

  @override
  Failure get failure => const ProfileRepositoryFailure();

  @override
  Future<Either<Failure, User>> getUser() => execute(() async {
        final localUser = await _getLocalUser();
        if (localUser != null) return localUser;

        final remoteProfile = await _getRemoteUser();

        final user = remoteProfile.toUserModel();
        final bonuses = remoteProfile.toBonusesModel();

        await _userLDS.saveUser(user.toEntity());
        await _bonusesLDS.saveBonuses(bonuses.toEntity());

        final savedUser = await _getLocalUser();
        if (savedUser == null) throw failure;

        return savedUser;
      });

  @override
  Future<Either<Failure, void>> updateUser(User user) => execute(
        () async => _profileRDS.updateProfile(user.toDto()).fold(
          (failure) => throw failure,
          (success) async {
            await _userLDS.updateUser(user.toEntity());
          },
        ),
      );

  Future<User?> _getLocalUser() async => _userLDS.getUser().fold(
        (failure) => throw failure,
        (userEntity) => userEntity?.toModel(),
      );

  Future<ProfileDto> _getRemoteUser() async => _profileRDS.getProfile().fold(
        (failure) => throw failure,
        (profile) => profile,
      );

  @override
  Future<Either<Failure, void>> deleteUser(User user) => execute(() async {
        _profileRDS.deleteAccount().fold(
          (failure) => throw failure,
          (success) async {
            if (success) {
              await _userLDS.deleteUser(user.toEntity());
            } else {
              // TODO: Точно ли это именно ошибка репозитория?
              throw failure;
            }
          },
        );
      });

  @override
  Future<Either<Failure, void>> logout() => execute(() async {
        _profileRDS.logout().fold(
              (failure) => throw failure,
              (success) => success,
            );
      });
}
