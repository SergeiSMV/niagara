import 'dart:ui';

/// Константы приложения
abstract final class AppConst {
  // ? ----------------------------- General ----------------------------- ? //

  static const double kCommon1 = 1;

  static const double kCommon2 = 2;

  static const double kCommon4 = 4;

  static const double kCommon8 = 8;

  static const double kCommon12 = 12;

  static const double kCommon16 = 16;

  static const double kCommon24 = 24;

  static const double kCommon32 = 32;

  static const double kCommon48 = 48;

  static const double kCommon64 = 64;

  // * ------------------------------ Icons ------------------------------ * //
  static const double kIconSmall = 16;

  static const double kIconMedium = 20;

  static const double kIconLarge = 24;

  // * ----------------------------- App Bar ----------------------------- * //
  static const double kAppBarDividerThickness = 1;

  // * ----------------------------- Buttons ----------------------------- * //
  static const double kButtonLarge = 54;

  static const double kButtonMedium = 44;

  static const double kButtonSmall = 32;

  static const double kButtonVerticalPadding = 12;

  static const double kButtonSmallVerticalPadding = 8;

  static const double kButtonHorizontalPadding = 24;

  static const double kButtonRadius = 12;

  static const double kButtonSmallRadius = 8;

  // * ---------------------------- Text Field ---------------------------- * //
  static const double kTextFieldRadius = 12;

  static const double kTextFieldPadding = 16;

  static const double kTextFieldVerticalPadding = 8;

  static const String kTextFieldPhoneName = 'phoneFiled';

  // * ------------------------------ Shadow ----------------------------- * //

  static const Offset kShadowOffset = Offset(0, -4);

  static const double kShadowBlur = 12;

  // ? --------------------------- Regional Data -------------------------- ? //
  static const int kPhoneDigits = 10;

  static const String kPhoneMask = '(###) ###-##-##';

  static const String kPhoneHint = '(000) 000-00-00';

  static const ({double latitude, double longitude}) kDefaultCity =
      (latitude: 55.1609, longitude: 61.4026); // Челябинск

  // ? ---------------------- Bottom Navigation Bar ---------------------- ? //
  static const double kNavBarIconSize = 24;

  static const double kNavBarIconPadding = 4;

  static const double kNavBarRadius = 16;

  // ? --------------------------- Splash Page --------------------------- ? //
  static const Duration kSplashLogoDuration = Duration(milliseconds: 1250);

  static const double kLoaderBottomOffset = 8;

  static const double kLoaderSize = 64;

  // ? ------------------------------- Auth ------------------------------ ? //
  static const double kAuthPrivacyPolicyBottomOffset = 12;

  // * ------------------------- Get Code Widget ------------------------- * //
  static const double kShadowOpacity = 0.06;

  static const double kGetCodeButtonTopPadding = 12;

  static const double kGetCodeButtonBottomPadding = 24;

  // * ------------------------- OTP Code Widget ------------------------- * //
  static const double kOTPCodeHeight = 72;

  static const double kOTPCodeWidth = 64;

  static const double kOTPCodeRadius = 12;

  static const double kOTPCodePreFilledSize = 4;

  static const int kOTPResendTime = 60;
}
