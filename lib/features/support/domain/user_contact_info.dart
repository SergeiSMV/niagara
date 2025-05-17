import '../../../core/core.dart';

/// Контактная информация пользователя.
class UserContactInfo extends Equatable {
  const UserContactInfo({
    required this.phone,
    required this.email,
    required this.name,
    this.description,
  });

  /// Номер телефона пользователя.
  final String phone;

  /// Email пользователя.
  final String email;

  /// Имя пользователя.
  final String name;

  /// Опциональное описание пользователя.
  final String? description;

  @override
  List<Object?> get props => [phone, email, name, description];
}
