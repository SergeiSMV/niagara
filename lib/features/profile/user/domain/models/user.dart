import 'package:niagara_app/core/core.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.userId,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.login,
    required this.phone,
    required this.email,
    required this.birthday,
    required this.defaultLocationId,
  });

  final int id;
  final String userId;
  final String name;
  final String surname;
  final String patronymic;
  final String login;
  final String phone;
  final String email;
  final String birthday;
  final String defaultLocationId;

  User copyWith({
    String? name,
    String? surname,
    String? patronymic,
    String? birthday,
    String? email,
  }) =>
      User(
        id: id,
        userId: userId,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        patronymic: patronymic ?? this.patronymic,
        login: login,
        phone: phone,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        defaultLocationId: defaultLocationId,
      );

  @override
  List<Object> get props => [
        id,
        userId,
        name,
        surname,
        patronymic,
        login,
        phone,
        email,
        birthday,
        defaultLocationId,
      ];
}
