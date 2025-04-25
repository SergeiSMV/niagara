import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/core.dart';
import '../../../core/dependencies/di.dart';
import '../../../core/utils/enums/auth_status.dart';
import '../../locations/cities/domain/models/city.dart';
import '../../locations/cities/domain/repositories/cities_repository.dart';
import '../../order_history/domain/models/user_order.dart';
import '../../order_history/domain/repositories/orders_repository.dart';
import '../../profile/bonuses/domain/models/bonuses.dart';
import '../../profile/bonuses/domain/repositories/bonuses_repository.dart';
import '../../profile/user/domain/models/user.dart';
import '../../profile/user/domain/repositories/profile_repository.dart';
import 'support_chat_credentials.dart';
import 'support_user_attributes.dart';
import 'user_contact_info.dart';

/// Репозиторий для получения данных для подключения к чату службы поддержки.
abstract interface class ISupportRepository {
  /// Получает данные для подключения к чату службы поддержки.
  Future<Either<Failure, SupportChatCredentials>> getSupportChatCredentials();

  /// Нужно ли очищать кэш сессии (удалять историю чатов).
  Future<Either<Failure, bool>> get shouldClearCache;

  /// Очищает кэш сессии (удаляет историю чатов).
  Future<Either<Failure, void>> clearCache();
}

@LazySingleton(as: ISupportRepository)
class SupportRepository extends BaseRepository implements ISupportRepository {
  SupportRepository(
    super._logger,
    super._networkInfo,
    this._authStatusStream,
  ) {
    initSubscription();
  }

  /// Инициализирует подписку на [Stream] статуса авторизации.
  ///
  /// Нужно для удаления истории чата при выходе из аккаунта.
  void initSubscription() {
    _authStatusStream.listen((status) {
      if (!status.hasAuth) {
        clearCache();
      }
    });
  }

  /// [Stream] статуса авторизации.
  final Stream<AuthenticatedStatus> _authStatusStream;

  @override
  Failure get failure => const SupportRepositoryFailure();

  @override
  Future<Either<Failure, SupportChatCredentials>>
      getSupportChatCredentials() async {
    // TODO: Это очень некрасиво, надо дождаться метода с бекенда.
    final res = await Future.wait([
      getIt<IOrdersRepository>().getOrders(page: 1, sort: null).fold(
            (failure) => throw failure,
            (orders) => orders.orders,
          ),
      getIt<ICitiesRepository>().getCity().fold(
            (failure) => throw failure,
            (city) => city,
          ),
      getIt<IBonusesRepository>().getBonuses().fold(
            (failure) => throw failure,
            (bonuses) => bonuses,
          ),
      getIt<IProfileRepository>().getUser().fold(
            (failure) => throw failure,
            (user) => user,
          ),
    ]);

    final orders = res[0] as List<UserOrder>;
    final city = res[1] as City;
    final bonuses = res[2] as Bonuses;
    final user = res[3] as User;

    final credentials = SupportChatCredentials(
      // TODO: Ссылка должна приходить с бекенда, могут удалить
      chatUrl: 'https://jivo.chat/AenBSnMXzu',
      userToken: '1234567890',
      userAttributes: SupportUserAttributes(
        values: {
          'city': city.name,
          'last_order_id': orders.firstOrNull?.id ?? 'Нет заказов',
          'app_version': '6.0.28+651',
          'bonus_count': bonuses.count,
        },
      ),
      contactInfo: UserContactInfo(
        phone: user.phone,
        email: user.email,
        name: user.name,
      ),
    );

    return Right(credentials);
  }

  @override
  Future<Either<Failure, bool>> get shouldClearCache async =>
      const Right(false);

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await InAppWebViewController.clearAllCache();
      return const Right(null);
    } on Object catch (_) {
      return Left(failure);
    }
  }
}
