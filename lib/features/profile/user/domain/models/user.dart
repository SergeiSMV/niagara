import 'package:intl/intl.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

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
    required this.ordersCount,
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
  final int ordersCount;

  /// Возращает дату рождения в формате `dd.mm.yyyy`.
  ///
  /// Возвращает `null`, если дата рождения не указана или приведена к
  /// стандартному значению ([AppConstants.kStandardDate]).
  String? get formattedBirthday {
    final DateTime? birthday = DateTime.tryParse(this.birthday);

    if (birthday == null ||
        birthday.isBefore(
          DateTime(AppConstants.kStandardDate),
        )) {
      return null;
    }

    return DateFormat('dd.MM.yyyy').format(birthday);
  }

  /// Возвращает `true`, если у пользователя есть обязательные данные (имя).
  bool get hasRequiredData => name.isNotEmpty;

  User copyWith({
    String? name,
    String? surname,
    String? patronymic,
    DateTime? birthday,
    String? email,
    int? ordersCount,
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
        // Обрезаем у даты часть после точки: 1969-07-20T20:18:04.000.
        birthday: birthday?.toIso8601String().split('.')[0] ?? this.birthday,
        defaultLocationId: defaultLocationId,
        ordersCount: ordersCount ?? this.ordersCount,
      );

  @override
  List<Object?> get props => [
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
        ordersCount,
      ];
}
