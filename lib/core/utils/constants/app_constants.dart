import 'dart:ui';

/// Константы приложения
abstract final class AppConst {
  // ? ----------------------------- General ----------------------------- ? //
  // * ----------------------------- Padding ----------------------------- * //
  /// Минимальный отступ
  static const double kPaddingMin = 4;

  /// Средний отступ
  static const double kPaddingMid = 8;

  /// Большой отступ
  static const double kPaddingMax = 16;

  // * ------------------------------ Icons ------------------------------ * //
  /// Иконки малого размера
  static const double kIconSmall = 16;

  /// Иконки среднего размера
  static const double kIconMedium = 20;

  /// Иконки большого размера
  static const double kIconLarge = 24;

  // * ----------------------------- App Bar ----------------------------- * //
  /// Толщина разделителя в AppBar
  static const double kAppBarDividerThickness = 1;

  // * ----------------------------- Buttons ----------------------------- * //
  /// Большая кнопка
  static const double kButtonLarge = 54;

  /// Средняя кнопка
  static const double kButtonMedium = 44;

  /// Маленькая кнопка
  static const double kButtonSmall = 32;

  /// Вертикальный отступ большой и средней кнопок
  static const double kButtonVerticalPadding = 12;

  /// Вертикальный отступ маленькой кнопки
  static const double kButtonSmallVerticalPadding = 8;

  /// Горизонтальный отступ кнопок
  static const double kButtonHorizontalPadding = 24;

  /// Закругление кнопок большой и средней
  static const double kButtonRadius = 12;

  /// Закругление кнопки маленькой
  static const double kButtonSmallRadius = 8;

  // * ---------------------------- Text Field ---------------------------- * //
  /// Радиус закругления текстового поля
  static const double kTextFieldRadius = 12;

  /// Отступы по горизонтали в текстовом поле
  static const double kTextFieldPadding = 16;

  /// Отступы по вертикали в текстовом поле
  static const double kTextFieldVerticalPadding = 8;
  
  /// Имя для текстового поля с номером телефона
  static const String kTextFieldPhoneName = 'phoneFiled';


  // ? --------------------------- Regional Data -------------------------- ? //
  /// Код страны
  static const String kCountryPhoneCode = '+7';

  /// Количество цифр в номере телефона
  static const int kPhoneDigits = 10;

  /// Маска для номера телефона
  static const String kPhoneMask = '(###) ###-##-##';

  /// Подсказка для номера телефона
  static const String kPhoneHint = '(000) 000-00-00';

  // ? ---------------------- Bottom Navigation Bar ---------------------- ? //
  /// Размер иконок в нижней навигации
  static const double kNavBarIconSize = 24;

  /// Отступ иконок в нижней навигации
  static const double kNavBarIconPadding = 4;

  /// Радиус скругления нижней навигации
  static const double kNavBarRadius = 16;

  // ? --------------------------- Splash Page --------------------------- ? //
  /// Длительность анимации появления логотипа
  static const Duration kSplashLogoDuration = Duration(milliseconds: 1250);

  /// Смещение лоадера от нижней части экрана
  static const double kLoaderBottomOffset = 8;

  /// Размер лоадера
  static const double kLoaderSize = 64;

  // ? ------------------------------- Auth ------------------------------ ? //
  /// Отступ от нижнего края экрана до пользовательского соглашения
  static const double kAuthPrivacyPolicyBottomOffset = 12;

  // * ------------------------- Get Code Widget ------------------------- * //
  /// Прозрачность для тени
  static const double kShadowOpacity = 0.06;

  /// Смещение тени
  static const Offset kShadowOffset = Offset(0, -4);

  /// Степень размытия тени
  static const double kShadowBlur = 12;

  /// Отступ от верхнего края элемента
  static const double kGetCodeButtonTopPadding = 12;

  /// Отступ от нижнего края элемента
  static const double kGetCodeButtonBottomPadding = 24;
}
