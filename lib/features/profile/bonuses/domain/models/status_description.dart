import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

/// Описание статуса аккаунта.
class StatusDescription extends Equatable {
  const StatusDescription({
    required this.level,
    required this.description,
    required this.minSum,
    required this.maxSum,
    required this.benefits,
    this.activationOptions,
  });

  /// Уровень статуса.
  final StatusLevel level;

  /// Описание статуса.
  final String description;

  /// Нижняя граница ежемесячных трат для получения статуса.
  final int minSum;

  /// Верхняя граница ежемесячных трат для получения статуса.
  ///
  /// При превышении - переход на следующий уровень.
  final int maxSum;

  /// Список преимуществ статуса.
  final List<BenefitDescription> benefits;

  /// Список опций для активации статуса.
  final List<ActivationOption>? activationOptions;

  @override
  List<Object?> get props => [level, description, minSum, maxSum, benefits];
}

/// Описание одного из преимуществ статуса.
class BenefitDescription extends Equatable {
  const BenefitDescription({
    required this.title,
    required this.description,
    required this.picture,
    required this.titleShort,
    required this.descriptionShort,
  });

  /// Заголовок пункта.
  final String title;

  /// Краткий заголовок пункта.
  ///
  /// Есть только у ВИП статуса.
  final String? titleShort;

  /// Описание пункта.
  final String description;

  /// Краткое описание пункта.
  ///
  /// Есть только у ВИП статуса.
  final String? descriptionShort;

  /// Изображение пункта.
  final BenefitPicture picture;

  @override
  List<Object?> get props => [
        title,
        description,
        picture,
        titleShort,
        descriptionShort,
      ];
}
