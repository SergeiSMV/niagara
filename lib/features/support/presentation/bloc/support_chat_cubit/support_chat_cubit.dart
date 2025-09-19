import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jivosdk_plugin/bridge.dart';

import '../../../../../core/core.dart';
import '../../../domain/support_chat_credentials.dart';
import '../../../domain/support_repository.dart';

part 'support_chat_state.dart';
part 'support_chat_cubit.freezed.dart';

/// [Cubit] для управления чатом службы поддержки
@injectable
class SupportChatCubit extends Cubit<SupportChatState> {
  SupportChatCubit(this._chatRepo)
      : super(const SupportChatState.notInitialized());

  /// Репозиторий для работы с чатом службы поддержки
  final ISupportRepository _chatRepo;

  /// Данные для подключения к чату службы поддержки.
  SupportChatCredentials? credentials;

  /// Счетчик непрочитанных сообщений
  int _unreadCount = 0;

  /// Текущее количество непрочитанных сообщений
  int get currentUnreadCount => _unreadCount;

  /// Получает данные для подключения к чату службы поддержки.
  Future<void> getUserCredentials() async {
    emit(const SupportChatState.loading());

    final result = await _chatRepo.getSupportChatCredentials();
    result.fold(
      (failure) => emit(const SupportChatState.error()),
      (data) async {
        credentials = data;

        /// Самое главное - валидная ссылка на чат. Все остальные параметры даже
        /// будучи некорректными не оказывают критического влияния на работу
        /// чата.
        final bool isValidUrl = credentials?.chatUrl.isNotEmpty ?? false;
        if (isValidUrl) {
          emit(const SupportChatState.initialized());
          // Запускаем отслеживание непрочитанных сообщений после инициализации
          _startUnreadCounterWatcher();
        } else {
          emit(const SupportChatState.error());
        }
      },
    );
  }

  /// Открывает чат службы поддержки.
  Future<void> openChat() async {
    if (credentials == null) {
      emit(const SupportChatState.error());
      return;
    } else {
      await _setupSession(credentials!);
      await Jivo.display.present();
    }
  }

  /// Устанавливает данные видимые оператором службы поддержки.
  Future<void> _setupSession(SupportChatCredentials creds) async {
    await Jivo.session.setup(
      channelId: creds.chatUrl,
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

  /// Запускает отслеживание счетчика непрочитанных сообщений
  /// НЕ инициализирует начальное состояние непрочитанных сообщений
  void _startUnreadCounterWatcher() {
    Jivo.session.startWatchingUnreadCounter((count) {
      count == 0 ? _unreadCount = count : _unreadCount++;
      emit(_UnreadCountChanged(count: _unreadCount));
    });
  }
}
