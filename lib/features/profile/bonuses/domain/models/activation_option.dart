import 'package:niagara_app/core/core.dart';

/// Способ активации вип-подписки.
class ActivationOption extends Equatable {
  const ActivationOption({
    required this.count,
    required this.sum,
    required this.sumForMounth,
    required this.title,
    required this.description,
    required this.descriptionFull,
    this.label,
  });

  /// Количество месяцев подписки.
  final String count;

  /// Общаяя стоимость.
  final String sum;

  /// Стоимость в месяц.
  final String sumForMounth;

  /// Название.
  final String title;

  /// Краткое описание. Отображается при выборе опции активации.
  final String description;

  /// Полное описание. Отображается при оплате.
  final String descriptionFull;

  /// Опциональная метка с пояснением.
  final String? label;

  @override
  List<Object?> get props => [
        count,
        sum,
        sumForMounth,
        title,
        description,
        descriptionFull,
        label,
      ];
}
