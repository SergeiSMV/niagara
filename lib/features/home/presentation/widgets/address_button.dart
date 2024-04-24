import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';

/// Кнопка в AppBar для отображения адреса доставки. При нажатии на кнопку
/// должен открываться экран с выбором адреса доставки.
class AppBarAddressButton extends StatelessWidget {
  /// Создает виджет кнопки в AppBar для отображения адреса доставки.
  const AppBarAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.textTypo.tx2SemiBold;
    final mainColor = context.colors.textColors.main;
    return InkWell(
      // TODO(Oleg): Реализовать переход на экран выбора адреса
      onTap: () => debugPrint('AddressButtonWidget'),
      child: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (_, state) => Row(
          children: [
            Text(
              state.locationName,
              style: textStyle.withColor(mainColor),
            ),
            AppConst.kCommon4.width,
            Assets.icons.arrowRight.svg(
              width: AppConst.kIconSmall,
              height: AppConst.kIconSmall,
              colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
