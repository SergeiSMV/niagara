import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';

abstract interface class IProfileRemoteDataSource {
  Future<Either<Failure, ProfileDto>> getProfile();
  Future<Either<Failure, void>> updateProfile(ProfileDto userDto);
  Future<Either<Failure, bool>> deleteAccount();
}

@LazySingleton(as: IProfileRemoteDataSource)
class ProfileRemoteDataSource implements IProfileRemoteDataSource {
  ProfileRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, ProfileDto>> getProfile() =>
      _requestHandler.sendRequest<ProfileDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetProfile,
        ),
        converter: ProfileDto.fromJson,
        failure: ProfileRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, void>> updateProfile(ProfileDto userDto) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kUpdateProfile,
          data: {
            ...userDto.toJson(),
            'PHONE': userDto.login,
          },
        ),
        converter: (json) => json['success'] as bool,
        failure: ProfileRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> deleteAccount() =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.delete(
          ApiConst.kDeleteProfile,
        ),
        converter: (json) => json['success'] as bool,
        failure: ProfileRemoteDataFailure.new,
      );
}
