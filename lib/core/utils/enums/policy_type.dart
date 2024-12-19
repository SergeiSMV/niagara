import 'package:niagara_app/core/utils/gen/strings.g.dart';

enum PolicyType {
  /// Пользовательское соглашение.
  agreement,

  /// Политика конфиденциальности.
  confidence;

  static PolicyType toEnum(String val) {
    switch (val) {
      case 'application':
        return PolicyType.agreement;
      case 'confidence':
        return PolicyType.confidence;
      default:
        return PolicyType.agreement;
    }
  }

  String get titleFirstLine => switch (this) {
        agreement => t.profile.aboutApp.agreementLine1,
        confidence => t.profile.aboutApp.policyLine1,
      };

  String get titleSecondLine => switch (this) {
        agreement => t.profile.aboutApp.agreementLine2,
        confidence => t.profile.aboutApp.policyLine2,
      };
}
