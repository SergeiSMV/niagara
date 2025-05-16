import '../../../../core/core.dart';

/// DTO для получения данных для чата службы поддержки.
class SupportChatCredentialsDto extends Equatable {
  const SupportChatCredentialsDto({
    required this.chatUrl,
    required this.userToken,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userDescription,
    required this.customAttributes,
  });

  factory SupportChatCredentialsDto.fromJson(Map<String, dynamic> json) =>
      SupportChatCredentialsDto(
        chatUrl: json['CHAT_URL'],
        userToken: json['USER_TOKEN'],
        userName: json['USER_NAME'],
        userEmail: json['USER_EMAIL'],
        userPhone: json['USER_PHONE'],
        userDescription: json['USER_DESCRIPTION'],
        customAttributes: Map.fromEntries(
          (json['customAttributes'] as List<dynamic>).map(
            (e) {
              e as Map<String, dynamic>;
              return MapEntry(e.keys.first, e.values.first);
            },
          ),
        ),
      );

  /// URL-адрес чата службы поддержки.
  /// `CHAT_URL`
  final String chatUrl;

  /// `JWT`-токен для аутентификации пользователя в чате.
  /// `USER_TOKEN`
  final String userToken;

  /// Имя пользователя.
  /// `USER_NAME`
  final String userName;

  /// Email пользователя.
  /// `USER_EMAIL`
  final String userEmail;

  /// Номер телефона пользователя.
  /// `USER_PHONE`
  final String userPhone;

  /// Описание пользователя.
  /// `USER_DESCRIPTION`
  final String userDescription;

  /// Дополнительные атрибуты пользователя.
  /// `customAttributes`
  final Map<String, dynamic> customAttributes;

  @override
  List<Object?> get props => [
        chatUrl,
        userToken,
        userName,
        userEmail,
        userPhone,
        userDescription,
        customAttributes,
      ];
}
