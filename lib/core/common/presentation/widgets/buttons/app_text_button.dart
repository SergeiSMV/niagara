import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/base_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/base_button_size.dart';
import 'package:niagara_app/core/utils/enums/base_button_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Кнопка с текстом [AppTextButton]. Поддерживает различные стили.
/// Поддерживает состояния загрузки и недоступность для нажатия.
class AppTextButton extends BaseButton {
  /// Создает экземпляр [AppTextButton] основного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.primary({
    super.key,
    this.text,
    this.icon,
    super.onTap,
    super.size,
  }) : super.primary(
          child: _buildWidgetOrNull(
            text: text,
            icon: icon,
            type: BaseButtonType.primary,
            size: size,
            inactive: onTap == null,
          ),
        );

  /// Создает экземпляр [AppTextButton] акцентного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.accent({
    super.key,
    this.text,
    this.icon,
    super.onTap,
    super.size,
  }) : super.accent(
          child: _buildWidgetOrNull(
            text: text,
            icon: icon,
            type: BaseButtonType.accent,
            size: size,
            inactive: onTap == null,
          ),
        );

  /// Создает экземпляр [AppTextButton] вторичного стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.secondary({
    super.key,
    this.text,
    this.icon,
    super.onTap,
    super.size,
  }) : super.secondary(
          child: _buildWidgetOrNull(
            text: text,
            icon: icon,
            type: BaseButtonType.secondary,
            size: size,
            inactive: onTap == null,
          ),
        );

  /// Создает экземпляр [AppTextButton] невидимого стиля.
  /// Описание параметров см. в [BaseButton].
  AppTextButton.invisible({
    required this.text,
    required super.onTap,
    this.icon,
    super.key,
    super.size,
  }) : super.invisible(
          child: _buildWidgetOrNull(
            text: text,
            icon: icon,
            type: BaseButtonType.invisible,
            size: size,
            inactive: onTap == null,
          ),
        );

  /// Создает виджет [Text] с указанным текстом и стилем с учетом размера кнопки
  /// или возвращает null, если текст не указан
  static Widget? _buildWidgetOrNull({
    required BaseButtonType type,
    required BaseButtonSize size,
    String? text,
    SvgGenImage? icon,
    bool inactive = false,
  }) {
    if (text == null) return null;
    return _TextButtonWidget(
      text: text,
      icon: icon,
      type: type,
      size: size,
      inactive: inactive,
    );
  }

  final String? text;
  final SvgGenImage? icon;
}

class _TextButtonWidget extends StatelessWidget {
  const _TextButtonWidget({
    required this.text,
    required this.type,
    required this.size,
    this.inactive = false,
    this.icon,
  });

  final String text;
  final BaseButtonType type;
  final BaseButtonSize size;
  final bool inactive;
  final SvgGenImage? icon;

  @override
  Widget build(BuildContext context) {
    final typo = context.textStyle.buttonTypo;
    final textColors = context.colors.textColors;

    final style = switch (type) {
      BaseButtonType.primary => typo.btn1bold,
      BaseButtonType.accent => typo.btn1bold,
      BaseButtonType.secondary => typo.btn1semiBold,
      BaseButtonType.invisible => typo.btn1semiBold,
    };

    Color adaptiveColor(Color color) => color.withOpacity(inactive ? 0.8 : 1);

    final color = switch (type) {
      BaseButtonType.primary => adaptiveColor(textColors.white),
      BaseButtonType.accent => adaptiveColor(textColors.white),
      BaseButtonType.secondary => adaptiveColor(textColors.main),
      BaseButtonType.invisible => adaptiveColor(textColors.accent),
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          AppConst.kCommon8.horizontalBox,
        ],
        Text(text, style: style.withColor(color)),
      ],
    ).paddingSymmetric(
      vertical: size.verticalPadding,
      horizontal: AppConst.kCommon24,
    );
  }
}
