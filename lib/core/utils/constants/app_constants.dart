import 'dart:ui';

/// Константы приложения
abstract final class AppConstants {
  // * ---------------------------- Text Field ---------------------------- * //
  static const String kTextFieldPhoneName = 'phoneFiled';
  static const String kTextFieldTextName = 'textField';
  static const String kNumberTextFieldName = 'numberField';
  static const String kSearchTextFieldName = 'searchField';
  static const String kPromocodeTextFieldName = 'promocodeField';
  static const String kBonusesTextFieldName = 'bonusesField';

  // * ------------------------------ Shadow ----------------------------- * //
  static const Offset kShadowTop = Offset(0, -4);
  static const Offset kShadowBottom = Offset(0, 4);

  // * --------------------------- Regional Data -------------------------- * //
  static const int kPhoneDigits = 10;
  static const String kPhoneMask = '(###) ###-##-##';
  static const String kPhoneHint = '(000) 000-00-00';
  static const (double, double) kDefaultCity = (55.1609, 61.4026); // Челябинск
  static const double kDefaultLowZoom = 16;
  static const double kDefaultHighZoom = 10;

  // * --------------------------- Splash Page --------------------------- * //
  static const Duration kSplashLogoDuration = Duration(milliseconds: 1250);

  // * ------------------------- OTP Code Widget ------------------------- * //
  static const int kOTPResendTime = 90;
  static const int kOTPChangeCount = 3;

  // * --------------------------- Order Number --------------------------- * //
  static const String orderNumber = '+7 (800) 505-10-21';
}
