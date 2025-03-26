import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/profile/user/data/local/entities/user_entity.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

extension UserEntityMapper on UserEntity {
  User toModel() => User(
        id: id,
        userId: userId,
        name: name,
        surname: surname,
        patronymic: patronymic,
        login: login,
        phone: phone,
        email: email,
        birthday: birthday,
        defaultLocationId: defaultLocationId,
        ordersCount: ordersCount,
      );

  UsersTableCompanion toCompanion() => UsersTableCompanion(
        id: Value(id),
        userId: Value(userId),
        name: Value(name),
        surname: Value(surname),
        patronymic: Value(patronymic),
        login: Value(login),
        phone: Value(phone),
        email: Value(email),
        birthday: Value(birthday),
        defaultLocationId: Value(defaultLocationId),
        ordersCount: Value(ordersCount),
      );
}

extension UserMapper on User {
  UserEntity toEntity() => UserEntity(
        id: id,
        userId: userId,
        name: name,
        surname: surname,
        patronymic: patronymic,
        login: login,
        phone: phone,
        email: email,
        birthday: birthday,
        defaultLocationId: defaultLocationId,
        ordersCount: ordersCount,
      );
}

extension UserCompanionMapper on UsersTableData {
  UserEntity toEntity() => UserEntity(
        id: id,
        userId: userId,
        name: name,
        surname: surname,
        patronymic: patronymic,
        login: login,
        phone: phone,
        email: email,
        birthday: birthday,
        defaultLocationId: defaultLocationId,
        ordersCount: ordersCount,
      );
}
