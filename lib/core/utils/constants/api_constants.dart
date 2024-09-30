part of '../../core.dart';

/// Константы для API
abstract final class ApiConst {
  // ? ----------------------------- General ------------------------------ ? //
  static const String kBaseUrl = 'API_HOST';

  static const String kLogin = 'API_LOGIN';

  static const String kPassword = 'API_PASSWORD';

  static const String kYandexGeo = 'YANDEX_GEO';

  /// DeepLink на приложение, использующийся для возврата пользователя после
  /// авторизации / подтверждения оплаты на сторонних сервисах.
  static const String kReturnUrl = '$kAppScheme$kAppLink';

  /// Схема приложения для обработки DeepLink.
  static const String kAppScheme = 'cordova://';

  /// Ссылка на приложение (часть после scheme).
  static const String kAppLink = 'niagara74.ru';

  // ? ------------------------------ Token ------------------------------- ? //
  /// -POST- Запрос на получение токена
  static const String kGetToken = '/get_token_session';

  /// -GET- Запрос на проверку токена
  static const String kCheckToken = '/check_token_session';

  // ? ------------------------------ Auth -------------------------------- ? //
  /// -POST- Запрос на создание кода для авторизации
  static const String kCreateCode = '/code_confirm_create';

  /// -POST- Запрос на проверку кода для авторизации
  static const String kConfirmCode = '/code_confirm_check';

  /// -POST- Запрос на выход из аккаунта
  static const String kLogout = '/user_checkout';

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

  /// -POST- Запрос на обновление профиля
  static const String kUpdateProfile = '/users';

  /// -DELETE- Запрос на удаление профиля
  static const String kDeleteProfile = '/users';

  /// -POST- Запрос на проверку кода подтверждения почты
  static const String kConfirmEmail = '/email_code_confirm_check';

  /// -POST- Запрос на создание кода подтверждения почты
  static const String kCreateEmailCode = '/email_code_confirm_create';

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

  /// -POST- Запрос на создание заказа ВИП-подписки
  static const String kOrderVip = '/orders_vip';

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

  /// -DELETE- Запрос на удаление товара из корзины
  static const String kRemoveProductFromCart = '/cart';

  /// -DELETE- Запрос на удаление всего количества заданного товара из корзины
  static const String kRemoveWholeProductCount = '/cart_clear_sku';

  /// -DELETE- Запрос на очистку корзины
  static const String kClearCart = '/cart_clear';

  /// -GET- Запрос на получение рекомендаций
  static const String kGetRecommendedProducts = '/cart_recommend';

  /// -POST- Запрос на применение промокода
  static const String kApplyPromoCode = '/poromocode_check';

  // ? -------------------------- New products ---------------------------- ? //
  /// -GET- Запрос на получение товаров "специально для вас".
  static const String kGetNewProducts = '/products_new';

  // ? ----------------------- Special products -------------------------- ? //
  /// -GET- Запрос на получение новых товаров.
  static const String kGetSpeialProducts = '/products_special';

  // ? ---------------------------- Stories ------------------------------- ? //
  /// -GET- Запрос на получение списка сториз.
  static const String kGetStories = '/stories';

  /// -POST- Запрос на отметку просмотренной сториз.
  static const String kMarkStorySeen = '/stories_check';

  // ? ----------------------------- Orders ------------------------------- ? //
  /// -GET- Запрос на получение списка заказов
  static const String kGetOrders = '/orders';

  /// -GET- Запрос на получение списка опций оценки заказа
  static const String kGetOrderRating = '/order_rating';

  /// -POST- Запрос на оценку заказа
  static const String kEvaluateOrder = '/order_rating';

  /// -GET- Запрос на получение списка доступных дат и временных промежутков
  /// доставки
  static const String kGetDeliveryTimeOptions = '/delivery_date';

  /// -POST- Запрос на создание заказа
  static const String kCreateOrder = '/orders';

  /// -GET- Запрос на получение чека заказа.
  static const String kGetReceipt = '/check';

  /// -DELETE- Запрос на отмену заказа
  static const String kCancelOrder = '/orders';

  /// -POST- Запрос на повторение заказа
  static const String kRepeatOrder = '/orders_repeat';

  // ? --------------------------- Referral ------------------------------- ? //
  /// -GET- Запрос на получение описания реферальной программы
  static const String kReferralInfo = '/referal_info';

  /// -GET- Запрос на получение истории приглашений
  static const String kReferralHistory = '/referal_history';

  /// -POST- Запрос на создание реферального кода
  static const String kReferralCode = '/referal_code';

  // ? --------------------------- Equipment ------------------------------ ? //
  /// -GET- Запрос на получение списка оборудований
  static const String kGetEquipments = '/devices';

  /// -GET- Запрос на получение доступных дат для заказа чистки оборудования
  static const String kGetCleaningDateRange = '/service_date';

  /// -GET- Запрос на получение списка слотов времени заказа чистки оборудования
  static const String kGetTimeSlotsForCleaning = '/time_service';

  /// -POST- Запрос на заказ чистки оборудования
  static const String kOrderCleaning = '/orders_servise';

  // ? ----------------------- Policies -------------------------- ? //
  /// -GET- Запрос на получение информации о приложении (политика
  /// конфиденциальности, публичная оферта и т.д.).
  static const String kGetPolicies = '/about_app';

  // ? ----------------------- Payments -------------------------- ? //
  /// -GET- Запрос на получение ссылки для подтверждения платежа
  static const String kGetConfirmationUrl = '/orders_payment';

  /// -GET- Запрос на получение статуса платежа
  static const String kGetPaymentStatus = '/orders_payment_status';

  // ? ----------------------- Water -------------------------- ? //
  /// -POST- Запрос на создание заказа на воду
  static const String kOrderPrepaidWater = '/orders_complect';
}
