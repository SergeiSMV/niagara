import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/data/local/data_source/bonuses_local_data_source.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_dto_mapper.dart';
import 'package:niagara_app/features/profile/bonuses/data/mappers/bonuses_entity_mapper.dart';
import 'package:niagara_app/features/profile/editing/data/email_editing_data_source.dart';
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
    this._emailRDS,
  );

  final IUserLocalDataSource _userLDS;
  final IBonusesLocalDataSource _bonusesLDS;
  final IProfileRemoteDataSource _profileRDS;
  final IEmailConfirmationDataSource _emailRDS;

  /// Подтверждаемый email. Меняется в случае, если вызывается [sendEmailCode] и
  /// используется при вызове [confirmEmail].
  String? _cachedEmail;

  @override
  Failure get failure => const ProfileRepositoryFailure();

  @override
  Future<Either<Failure, User>> getUser() => execute(() async {
        // TODO(kvbykov): Вернуть работу с кешем пользователя после устранения 
        // багов.
        // final localUser = await _getLocalUser();
        // if (localUser != null) return localUser;

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
  Future<Either<Failure, void>> updateUser(User user) => execute(() async {
        _profileRDS.updateProfile(user.toDto()).fold(
              (failure) => throw failure,
              (_) => _userLDS.updateUser(user.toEntity()),
            );
      });

  Future<User?> _getLocalUser() async => _userLDS.getUser().fold(
        (failure) => throw failure,
        (userEntity) => userEntity?.toModel(),
      );

  Future<ProfileDto> _getRemoteUser() async => _profileRDS.getProfile().fold(
        (failure) => throw failure,
        (profile) => profile,
      );

  @override
  Future<Either<Failure, void>> deleteUser({
    required User user,
    bool fromRemote = true,
  }) =>
      execute(() async {
        if (fromRemote) {
          _profileRDS.deleteAccount().fold(
            (failure) => throw failure,
            (success) async {
              if (success) {
                await _userLDS.deleteUser(user.toEntity());
                await _bonusesLDS.clear();
              } else {
                throw failure;
              }
            },
          );
        } else {
          await _userLDS.deleteUser(user.toEntity());
          await _bonusesLDS.clear();
        }
      });

  @override
  Future<Either<Failure, void>> confirmEmail({
    required String code,
  }) =>
      execute(() async {
        final String? email = _cachedEmail;
        if (email == null) throw const EmailNotFoundFailure();

        return _emailRDS.confirmEmailCode(code: code, email: email).fold(
              (failure) => throw failure,
              (status) => status ? null : throw const EmailConfirmCodeFailure(),
            );
      });

  @override
  Future<Either<Failure, void>> sendEmailCode({
    required String email,
  }) =>
      execute(() async {
        _cachedEmail = email;

        return _emailRDS.createEmailCode(email: email).fold(
              (failure) => throw failure,
              (status) => status ? null : throw const EmailCreateCodeFailure(),
            );
      });
}
