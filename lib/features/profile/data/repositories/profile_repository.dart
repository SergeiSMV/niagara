import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/data/local/data_source/user_local_data_source.dart';
import 'package:niagara_app/features/profile/data/mappers/bonuses_dto_mapper.dart';
import 'package:niagara_app/features/profile/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/data/mappers/user_dto_mapper.dart';
import 'package:niagara_app/features/profile/data/mappers/user_entity_mapper.dart';
import 'package:niagara_app/features/profile/data/remote/data_source/profile_remote_data_source.dart';
import 'package:niagara_app/features/profile/data/remote/dto/profile_dto.dart';
import 'package:niagara_app/features/profile/domain/models/user.dart';
import 'package:niagara_app/features/profile/domain/repositories/profile_repository.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository extends BaseRepository implements IProfileRepository {
  ProfileRepository({
    required IUserLocalDataSource userLocalDataSource,
    required IBonusesLocalDataSource bonusesLocalDataSource,
    required IProfileRemoteDataSource profileRemoteDataSource,
    required super.logger,
  })  : _userLocalDataSource = userLocalDataSource,
        _bonusesLocalDataSource = bonusesLocalDataSource,
        _profileRemoteDataSource = profileRemoteDataSource;

  final IUserLocalDataSource _userLocalDataSource;
  final IBonusesLocalDataSource _bonusesLocalDataSource;
  final IProfileRemoteDataSource _profileRemoteDataSource;

  @override
  Failure get failure => const ProfileRepositoryFailure();

  @override
  Future<Either<Failure, User>> getUser() => execute(() async {
        final localUser = await _getLocalUser();
        if (localUser != null) return localUser;

        final remoteProfile = await _getRemoteUser();

        final user = remoteProfile.toUserModel();
        final bonuses = remoteProfile.toBonusesModel();

        await _userLocalDataSource.saveUser(user.toEntity());
        await _bonusesLocalDataSource.saveBonuses(bonuses.toEntity());

        final savedUser = await _getLocalUser();
        if (savedUser == null) throw failure;

        return savedUser;
      });

  @override
  Future<Either<Failure, void>> updateUser(User user) => execute(() async {
        await _profileRemoteDataSource.updateProfile(user.toDto()).fold(
          (failure) => throw failure,
          (success) async {
            await _userLocalDataSource.updateUser(user.toEntity());
          },
        );
      });

  Future<User?> _getLocalUser() async => _userLocalDataSource.getUser().fold(
        (failure) => throw failure,
        (userEntity) => userEntity?.toModel(),
      );

  Future<ProfileDto> _getRemoteUser() async =>
      _profileRemoteDataSource.getProfile().fold(
            (failure) => throw failure,
            (profile) => profile,
          );
}
