import 'dart:ui';

/// Константы приложения
abstract final class AppConstants {
  /// Должна ли отображаться кнопка, открывающая логи.
  ///
  /// Для установки `true` используйте `main_dev.dart`.
  static bool kShowDebugButton = false;

  // * ------------------------------- DB ------------------------------- * //

  static const String kCitiesTable = 'cities_table';
  static const String kPoliciesTable = 'categories_table';
  static const String kShopsTable = 'shops_table';

  /// Список названий таблиц, которые не нужно очищать при выходе из аккаунта.
  static const Set<String> kNoClearTables = {
    // Пока что не реализована смена города
    kCitiesTable,

    // Нет смысла очищать эту базу
    kPoliciesTable,

    // Зависит от города, который не меняется при логауте.
    kShopsTable,
  };

  // * ---------------------------- Text Field ---------------------------- * //
  static const String kTextFieldPhoneName = 'phoneFiled';
  static const String kTextFieldTextName = 'textField';
  static const String kNumberTextFieldName = 'numberField';
  static const String kSearchTextFieldName = 'searchField';
  static const String kPromocodeTextFieldName = 'promocodeField';
  static const String kBonusesTextFieldName = 'bonusesField';
  static const String kEmailTextFieldName = 'emailField';

  // * ------------------------------- Shadow ----------------------------- * //
  static const Offset kShadowTop = Offset(0, -4);
  static const Offset kShadowBottom = Offset(0, 4);
  static const Offset kShadowDiagonal = Offset(-2, 6);

  // * --------------------------- Regional Data -------------------------- * //
  static const int kPhoneDigits = 10;
  static const String kPhoneMask = '(###) ###-##-##';
  static const String kPhoneHint = '(000) 000-00-00';
  static const (double, double) kDefaultCity = (55.1609, 61.4026); // Челябинск
  static const double kDefaultLowZoom = 16;
  static const double kDefaultHighZoom = 10;

  // * --------------------------- Splash Page ---------------------------- * //
  static const Duration kSplashLogoDuration = Duration(milliseconds: 1250);

  // * -------------------------- OTP Code Widget ------------------------- * //
  static const int kOTPResendTime = 90;
  static const int kOTPChangeCount = 3;

  // * --------------------------- Order Number --------------------------- * //
  static const String orderNumber = '+7 (800) 505-10-21';

  // * --------------------------- Call Center Number --------------------------- * //
  static const String callCenterNumber = '+7 (351) 2-111-000';

  // * ----------------------------- Stories ------------------------------ * //
  static const lightSlideGradientStops1 = [0.0, 0.497, 0.8434, 1.0];

  static const lightSlideGradientStops2 = [0.0, 0.5781, 1.0];

  static const darkSlideGradientStops1 = [0.0, 0.578025, 0.578125, 1.0];

  static const darkSlideGradientStops2 = [0.0, 0.497046, 0.769, 1.0];

  // * ------------------------------ Banners ----------------------------- * //
  static const profileBannersStops = [0.0825, 0.9176];

  // * ------------------------------ Slides ------------------------------ * //
  static const double slideExtentRatio = 0.2;

  // * ------------------------------ Dates ----------------------------- --* //
  static const int kStandardDate = 2;

  // * ------------------------------ Cart -------------------------------- * //
  static const int kZeroBonusesToPay = 0;

  // * ------------------------------ Max Text Lines ---------------------- * //
  static const int kMaxLines1 = 1;
  static const int kMaxLines2 = 2;
  static const int kMaxLines3 = 3;

  // * ------------------------------ GridView ---------------------------- * //
  static const int kCrossAxis2 = 2;
  static const int kHeightCorrector50 = 50;

  // * ------------------------------ Flexible ---------------------------- * //
  static const int kFlexe4 = 4;
}
