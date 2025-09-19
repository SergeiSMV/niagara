import '../gen/strings.g.dart';

/// Типы соглашений
enum PolicyType {
  /// Пользовательское соглашение.
  agreement,

  /// Политика конфиденциальности.
  confidence,

  /// Маркетинговое соглашение.
  marketing;

  /// Преобразование строки в тип соглашения
  static PolicyType toEnum(String val) {
    switch (val) {
      case 'application':
        return PolicyType.agreement;
      case 'confidence':
        return PolicyType.confidence;
      case 'marketing':
        return PolicyType.marketing;
      default:
        return PolicyType.agreement;
    }
  }

  /// Заголовок первой строки
  String get titleFirstLine => switch (this) {
        agreement => t.profile.aboutApp.agreementLine1,
        confidence => t.profile.aboutApp.policyLine1,
        marketing => t.profile.aboutApp.marketingLine1,
      };

  /// Заголовок второй строки
  String get titleSecondLine => switch (this) {
        agreement => t.profile.aboutApp.agreementLine2,
        confidence => t.profile.aboutApp.policyLine2,
        marketing => t.profile.aboutApp.marketingLine2,
      };
}
