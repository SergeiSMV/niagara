import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jivosdk_plugin/bridge.dart';

import '../../../core/core.dart';
import '../domain/support_chat_credentials.dart';
import '../domain/support_repository.dart';
import 'support_chat_state.dart';

/// [Cubit] для управления чатом службы поддержки.
@injectable
class SupportCubit extends Cubit<SupportChatState> {
  SupportCubit(this._chatRepo) : super(SupportChatState.notInitialized);

  /// Репозиторий для работы с чатом службы поддержки.
  final ISupportRepository _chatRepo;

  /// Данные для подключения к чату службы поддержки.
  SupportChatCredentials? credentials;

  /// Получает данные для подключения к чату службы поддержки.
  Future<void> getUserCredentials() async {
    emit(SupportChatState.loading);

    final result = await _chatRepo.getSupportChatCredentials();
    result.fold(
      (failure) => emit(SupportChatState.error),
      (data) async {
        credentials = data;

        /// Самое главное - валидная ссылка на чат. Все остальные параметры даже
        /// будучи некорректными не оказывают критического влияния на работу
        /// чата.
        final bool isValidUrl = credentials?.chatUrl.isNotEmpty ?? false;
        if (isValidUrl) {
          emit(SupportChatState.initialized);
        } else {
          emit(SupportChatState.error);
        }
      },
    );
  }

  /// Открывает чат службы поддержки.
  Future<void> openChat() async {
    if (credentials == null) {
      emit(SupportChatState.error);
      return;
    } else {
      await _setupSession(credentials!);
      await Jivo.display.present();
    }
  }

  /// Устанавливает данные видимые оператором службы поддержки.
  Future<void> _setupSession(SupportChatCredentials creds) async {
    await Jivo.session.setup(
      // channelId: creds.chatUrl, // `widget_id` в консоли Jivo - ID канала
      channelId: 'zFZoRAwxfc',
      userToken: creds.userToken, // JWT-токен для идентификации пользователя
      // (нужен для сохранения истории чатов)
    );

    await Jivo.session.setContactInfo(
      name: creds.contactInfo.name,
      email: creds.contactInfo.email,
      phone: creds.contactInfo.phone,
      brief: creds.contactInfo.description,
    );

    final atrs = creds.userAttributes.jivoFields;

    if (atrs.isNotEmpty) {
      // кастомные атрибуты пользователя
      // (секция `Extra info` внутри чата)
      await Jivo.session.setCustomData(atrs);
    }
  }
}
