import 'package:niagara_app/core/utils/constants/app_constants.dart';

/// Тип размера кнопки из списка предопределенных значений
enum BaseButtonSize {
  small(
    height: AppConst.kButtonSmall,
    verticalPadding: AppConst.kCommon8,
    borderRadius: AppConst.kCommon8,
  ),

  medium(
    height: AppConst.kButtonMedium,
    verticalPadding: AppConst.kCommon12,
    borderRadius: AppConst.kCommon12,
  ),

  large(
    height: AppConst.kButtonLarge,
    verticalPadding: AppConst.kCommon12,
    borderRadius: AppConst.kCommon12,
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
