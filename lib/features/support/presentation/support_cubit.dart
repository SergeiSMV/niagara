import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

  /// Контроллер WebView.
  ///
  /// `N.B:` `dispose` вызывается автоматически при закрытии страницы.
  /// Если вызвать его вручную, возникает ошибка.
  InAppWebViewController? _controller;

  /// Данные для подключения к чату службы поддержки.
  SupportChatCredentials? _credentials;

  /// URL чата службы поддержки.
  WebUri? get chatUrl => _credentials?.chatUrl != null
      ? WebUri.uri(Uri.parse(_credentials!.chatUrl))
      : null;

  /// Получает данные для подключения к чату службы поддержки.
  Future<void> getUserCredentials() async {
    emit(SupportChatState.loading);

    final result = await _chatRepo.getSupportChatCredentials();
    result.fold(
      (failure) => emit(SupportChatState.error),
      (credentials) async {
        _credentials = credentials;

        /// Самое главное - валидная ссылка на чат. Все остальные параметры даже
        /// будучи некорректными не оказывают критического влияния на работу
        /// чата.
        final bool isValidUrl = Uri.tryParse(_credentials!.chatUrl) != null;
        if (isValidUrl) {
          emit(SupportChatState.initialized);
        } else {
          emit(SupportChatState.error);
        }
      },
    );
  }

  /// Устанавливает контроллер WebView.
  Future<void> onControllerReady(InAppWebViewController controller) async {
    _controller = controller;
    await _setUserCredentials();
  }

  /// Устанавливает данные видимые оператором службы поддержки.
  Future<void> _setUserCredentials() async {
    if (_controller == null) {
      emit(SupportChatState.error);
      return;
    }

    if (_credentials == null) return;

    await _setUserToken();
    await _setUserInfo();

    emit(SupportChatState.initialized);
  }

  /// Устанавливает данные видимые оператором службы поддержки.
  Future<void> _setUserInfo() async {
    final jsScript = '''
            if (typeof jivo_api !== 'undefined') {
              jivo_api.setContactInfo({
                name: "${_credentials!.contactInfo.name}",
                email: "${_credentials!.contactInfo.email}",
                phone: "${_credentials!.contactInfo.phone}",
                description: "${_credentials!.contactInfo.description}",
              });

              jivo_api.setClientAttributes({
                ${_credentials!.userAttributes.formatted}
              });
            }
          ''';

    await Future.delayed(const Duration(seconds: 1));
    await _controller?.evaluateJavascript(
      source: jsScript,
    );
  }

  /// Устанавливает `JWT`-токен для аутентификации пользователя в чате.
  Future<void> _setUserToken() async {
    final token = _credentials!.userToken;
    if (token.isEmpty) return;

    await Future.delayed(const Duration(seconds: 1));
    await _controller!.evaluateJavascript(
      source: '''
              if (typeof jivo_api !== 'undefined') {
                 jivo_api.setUserToken("${_credentials!.userToken}");
              }
            ''',
    );
  }
}
