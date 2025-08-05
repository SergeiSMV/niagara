// ignore_for_file: sort_constructors_first

import '../../../../../core/core.dart';

/// Пара `Access-Token` [token] и `Refresh-Token` [deviceId] для авторизации
/// запросов к серверу.
class CredentialsDto extends Equatable {
  const CredentialsDto({
    required this.token,
    required this.deviceId,
  });

  /// `Access-Token` текущей сессии.
  final String token;

  /// `Refresh-Token` текущей сессии.
  ///
  /// Соответствует идентификатору устройства и валиден вечно.
  final String? deviceId;

  /// Создаёт [CredentialsDto] из JSON-представления.
  factory CredentialsDto.fromJson(Map<String, dynamic> json) => CredentialsDto(
        token: json['token'] as String,
        deviceId: json['device_id'] as String?,
      );

  @override
  List<Object?> get props => [token, deviceId];
}
