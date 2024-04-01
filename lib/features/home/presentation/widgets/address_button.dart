import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Кнопка в AppBar для отображения адреса доставки. При нажатии на кнопку
/// должен открываться экран с выбором адреса доставки.
class AppBarAddressButton extends StatelessWidget {
  /// Создает виджет кнопки в AppBar для отображения адреса доставки.
  const AppBarAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor = context.colors.textColors.main;
    return InkWell(
      // TODO(Oleg): Реализовать переход на экран выбора адреса
      onTap: () => debugPrint('AddressButtonWidget'),
      child: Row(
        children: [
          Text(
            // TODO(Oleg): Реализация реального адреса
            'ул. Ростовское ш., дом 22/б',
            style: context.textStyle.textTypo.tx2SemiBold.withColor(mainColor),
          ),
          AppConst.kPaddingMin.width,
          Assets.icons.arrowRight.svg(
            width: AppConst.kIconSmall,
            height: AppConst.kIconSmall,
            colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
