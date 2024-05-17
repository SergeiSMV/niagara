import 'package:niagara_app/features/profile/user/data/remote/dto/profile_dto.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

extension UserDtoMapper on ProfileDto {
  User toUserModel() => User(
        id: id.hashCode,
        userId: id,
        name: name,
        surname: lastName,
        patronymic: secondName,
        login: login,
        phone: login,
        email: email,
        birthday: birthday,
        defaultLocationId: locationDefault,
      );
}

extension UserMapper on User {
  ProfileDto toDto() => ProfileDto(
        id: userId,
        name: name,
        lastName: surname,
        secondName: patronymic,
        login: login,
        email: email,
        city: '',
        birthday: birthday,
        bonusesCardNumber: '',
        bonusesCount: '0',
        bonusesTempCount: '0',
        bonusesTempLastDate: '',
        bonusesTempDays: '0',
        bonusesLevel: '',
        bonusesLevelNext: '',
        bonusesDateEnd: DateTime.now(),
        revThisMonth: 0,
        bottlesCount: 0,
        bottles: const [],
        locationDefault: defaultLocationId,
      );
}
