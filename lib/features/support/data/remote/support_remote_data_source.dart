import '../../../../core/core.dart';
import 'support_chat_credentials_dto.dart';

/// Источник данных для чата службы поддержки.
abstract interface class ISupportRemoteDataSource {
  /// Получает данные для чата службы поддержки.
  Future<Either<Failure, SupportChatCredentialsDto>>
      getSupportChatCredentials();
}

/// Источник данных для чата службы поддержки.
@LazySingleton(as: ISupportRemoteDataSource)
class SupportRemoteDataSource implements ISupportRemoteDataSource {
  SupportRemoteDataSource(this._requestHandler);

  /// Обработчик запросов.
  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, SupportChatCredentialsDto>>
      getSupportChatCredentials() async => _requestHandler
              .sendRequest<SupportChatCredentialsDto, Map<String, dynamic>>(
            request: (dio) => dio.get(ApiConst.kGetSupportChatCredentials),
            converter: SupportChatCredentialsDto.fromJson,
            failure: SupportRemoteDataFailure.new,
          );
}
