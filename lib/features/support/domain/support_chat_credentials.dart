import '../../../core/core.dart';
import 'support_user_attributes.dart';
import 'user_contact_info.dart';

/// Информация о пользователе для чата службы поддержки.
class SupportChatCredentials extends Equatable {
  const SupportChatCredentials({
    required this.chatUrl,
    required this.userToken,
    required this.userAttributes,
    required this.contactInfo,
  });

  /// URL-адрес чата службы поддержки.
  ///
  /// По данной ссылке откроется чат-страница Jivo определенного канала.
  final String chatUrl;

  /// `JWT`-токен для аутентификации пользователя в чате.
  ///
  /// Нужен для синхронизации истории чатов на разных устройствах или
  /// после очистки `localStoarage` WebView.
  ///
  /// Также позволяет идентифицировать пользователя по событиям Jivo WebhookAPI.
  final String userToken;

  /// Набор кастомных атрибутов пользователя, настраиваемых в консоли
  /// Jivo.
  ///
  /// Например, можно использовать для хранения номера телефона, email,
  /// имени и т.д.
  final SupportUserAttributes userAttributes;

  /// Контактная информация пользователя.
  final UserContactInfo contactInfo;

  @override
  List<Object?> get props => [chatUrl, userToken, userAttributes, contactInfo];
}
