import '../../domain/support_chat_credentials.dart';
import '../../domain/support_user_attributes.dart';
import '../../domain/user_contact_info.dart';
import '../remote/support_chat_credentials_dto.dart';

extension SupportChatCredentialsMapper on SupportChatCredentialsDto {
  SupportChatCredentials toModel() => SupportChatCredentials(
        chatUrl: chatUrl,
        userToken: userToken,
        userAttributes: SupportUserAttributes(values: customAttributes),
        contactInfo: UserContactInfo(
          phone: userPhone,
          email: userEmail,
          name: userName,
          description: userDescription,
        ),
      );
}
