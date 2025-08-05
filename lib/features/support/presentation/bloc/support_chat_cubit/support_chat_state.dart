part of 'support_chat_cubit.dart';

@freezed
class SupportChatState with _$SupportChatState {
  const factory SupportChatState.notInitialized() = _NotInitialized;
  const factory SupportChatState.loading() = _Loading;
  const factory SupportChatState.initialized() = _Initialized;
  const factory SupportChatState.error() = _Error;

  const factory SupportChatState.unreadCountChanged({required int count}) =
      _UnreadCountChanged;
}
