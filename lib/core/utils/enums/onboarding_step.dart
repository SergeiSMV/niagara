import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Этап онбординга.
enum OnboardingStep {
  /// Приветствие.
  greeting,

  /// Запрос разрешения на отправку уведомлений.
  notification,

  /// Запрос разрешения на геопозицию.
  geoposition,

  /// Онбординг завершён.
  finished;

  /// Возвращает `true`, если этап можно пропустить.
  bool get skippable => this == notification || this == geoposition;

  /// Возвращает изображение для этапа онбординга.
  AssetGenImage get image => switch (this) {
        greeting => Assets.images.onboardingGreeting,
        notification => Assets.images.onboardingNotifications,
        geoposition => Assets.images.onboardingLocation,
        finished => throw Exception('No image for finished step'),
      };

  /// Возвращает заголовок для этапа онбординга.
  String get title => switch (this) {
        greeting => t.onboarding.greeting.title,
        notification => t.onboarding.notifications.title,
        geoposition => t.onboarding.location.title,
        finished => throw Exception('No title for finished step'),
      };

  /// Возвращает описание для этапа онбординга.
  String get description => switch (this) {
        greeting => t.onboarding.greeting.description,
        notification => t.onboarding.notifications.description,
        geoposition => t.onboarding.location.description,
        finished => throw Exception('No description for finished step'),
      };
}
