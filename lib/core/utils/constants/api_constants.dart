part of '../../core.dart';

/// Константы для API
abstract final class ApiConst {
  // ? ----------------------------- General ----------------------------- ? //
  static const String kBaseUrl = 'API_HOST';

  static const String kLogin = 'API_LOGIN';

  static const String kPassword = 'API_PASSWORD';

  static const String kYandexGeo = 'YANDEX_GEO';

  // ? ------------------------------ Token ------------------------------ ? //
  /// -POST- Запрос на получение токена
  static const String kGetToken = '/get_token_session';

  /// -GET- Запрос на проверку токена
  static const String kCheckToken = '/check_token_session';

  // ? ------------------------------ Auth ------------------------------- ? //
  /// -POST- Запрос на создание кода для авторизации
  static const String kCreateCode = '/code_confirm_create';

  /// -POST- Запрос на проверку кода для авторизации
  static const String kConfirmCode = '/code_confirm_check';

  // ? ----------------------------- Location ----------------------------- ? //
  /// -GET- Запрос на получение списка городов
  static const String kGetCities = '/region';

  /// -POST- Запрос на добавление города
  static const String kSetCity = '/city_check';

  /// -GET- Запрос на получение списка локаций
  static const String kGetLocations = '/location';

  /// -POST- Запрос на добавление локации
  static const String kAddLocation = '/location';

  /// -PUT- Запрос на добавление локации
  static const String kUpdateLocation = '/location';

  /// -DELETE- Запрос на удаление локации
  static const String kDeleteLocation = '/location';

  /// -POST- Проверка на зону доставки локации
  static const String kCheckLocation = '/check_location';

  /// -GET- Запрос на получение списка магазинов
  static const String kGetShops = '/stores';

  // ? ------------------------------- User ------------------------------- ? //
  /// -GET- Запрос на получение профиля
  static const String kGetProfile = '/users';

  /// -PUT- Запрос на обновление профиля
  static const String kUpdateProfile = '/users';

  // ? --------------------------- BonusProgram --------------------------- ? //
  /// -GET- Запрос на получение описания программы бонусов
  static const String kGetBonusProgram = '/bonus_program';

  /// -GET- Запрос на получение FAQ программы бонусов
  static const String kGetFaqBonusProgram = '/faq';

  /// -GET- Запрос на получение описания статусов
  static const String kGetStatusesDescriptions = '/bonus_program_status';

  /// -GET- Запрос на получение описания статуса
  static const String kGetStatusDescription = '/status_users';

  /// -GET- Запрос на получение истории бонусов
  static const String kGetBonusesHistory = '/history';

  // ? ------------------------------ Promos ------------------------------ ? //
  /// -GET- Запрос на получение списка акции
  static const String kGetPromos = '/offers';

  // ? ------------------------------ Catalog ----------------------------- ? //
  /// -GET- Запрос на получение списка групп
  static const String kGetGroups = '/product_groups';

  /// -GET- Запрос на получение списка товаров
  static const String kGetCategory = '/products';

  /// -GET- Запрос на получение списка рекомендаций
  static const String kGetRecommend = '/recommend';

  /// -GET- Запрос на получение списка фильтров
  static const String kGetFilters = '/filters';

  /// -GET- Запрос на получение списка товаров по поиску
  static const String kGetProductSearch = '/product_search';

  // ? ---------------------------- Favorite ------------------------------ ? //
  /// -GET- Запрос на получение списка избранных товаров
  static const String kGetFavorites = '/favourites';

  /// -POST- Запрос на добавление товара в избранное
  static const String kAddFavorite = '/favourites';

  /// -DELETE- Запрос на удаление товара из избранного
  static const String kRemoveFavorite = '/favourites';

  /// -DELETE- Запрос на очистку избранного
  static const String kClearFavorite = '/favourites_clear';

  // ? -------------------------- Notifications --------------------------- ? //
  /// -GET- Запрос на получение списка уведомлений
  static const String kGetNotifications = '/notification';

  /// -POST- Запрос на прочтение уведомления
  static const String kReadNotifications = '/notification_check';

  // ? ------------------------------ Cart -------------------------------- ? //
  /// -POST- Запрос на получение корзины
  static const String kGetCart = '/cart_calculate';

  /// -POST- Запрос на добавление товара в корзину
  static const String kAddProductToCart = '/cart';

  /// -POST- Запрос на удаление товара из корзины
  static const String kRemoveProductFromCart = '/cart';

  /// -POST- Запрос на очистку корзины
  static const String kClearCart = '/cart_clear';

  /// -GET- Запрос на получение рекомендаций
  static const String kGetRecommendedProducts = '/cart_recommend';

  // ? -------------------------- New products ---------------------------- ? //
  /// -GET- Запрос на получение товаров "специально для вас".
  static const String kGetNewProducts = '/products_new';

  // ? ----------------------- Special products -------------------------- ? //
  /// -GET- Запрос на получение новых товаров.
  static const String kGetSpeialProducts = '/products_special';

  // ? ----------------------- Stories -------------------------- ? //
  /// -GET- Запрос на получение списка сториз.
  static const String kGetStories = '/stories';

  /// -POST- Запрос на отметку просмотренной сториз.
  static const String kMarkStorySeen = '/stories_check';
}
