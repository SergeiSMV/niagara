import 'package:niagara_app/core/utils/constants/app_sizes.dart';

/// Тип размера кнопки из списка предопределенных значений
enum BaseButtonSize {
  small(
    height: AppSizes.kButtonSmall,
    verticalPadding: AppSizes.kGeneral8,
    borderRadius: AppSizes.kGeneral8,
  ),

  medium(
    height: AppSizes.kButtonMedium,
    verticalPadding: AppSizes.kGeneral12,
    borderRadius: AppSizes.kGeneral12,
  ),

  large(
    height: AppSizes.kButtonLarge,
    verticalPadding: AppSizes.kGeneral12,
    borderRadius: AppSizes.kGeneral12,
  );

  /// Высота кнопки
  final double height;

  /// Вертикальный отступ кнопки
  final double verticalPadding;

  /// Радиус скругления кнопки
  final double borderRadius;

  // ignore: sort_constructors_first
  const BaseButtonSize({
    required this.height,
    required this.verticalPadding,
    required this.borderRadius,
  });
}
