import 'package:niagara_app/core/core.dart';

class Policy extends Equatable {
  const Policy({
    required this.html,
  });

  final String html;

  @override
  List<Object?> get props => [html];
}

enum PolicyType {
  /// Пользовательское соглашение.
  application,

  /// Оферта на продажу товаров.
  offer,

  /// Политика конфиденциальности.
  confidence;

  static PolicyType toEnum(String val) {
    switch (val) {
      case 'application':
        return PolicyType.application;
      case 'offer':
        return PolicyType.offer;
      case 'confidence':
        return PolicyType.confidence;
      default:
        return PolicyType.application;
    }
  }
}
