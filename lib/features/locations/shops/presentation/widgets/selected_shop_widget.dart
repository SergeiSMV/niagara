import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedShopWidget extends StatelessWidget {
  const SelectedShopWidget({
    required this.shop,
    super.key,
  });

  final Shop shop;

  Future<void> _onBuildMapRoute(BuildContext context) async {
    final latitude = shop.coordinates.$1;
    final longitude = shop.coordinates.$2;

    final iosUrl =
        Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');

    final androidUrl = Uri.parse(
      'geo:$latitude,$longitude?q=$latitude,$longitude($shop.name)',
    );

    final url = Platform.isIOS ? iosUrl : androidUrl;
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  void _onUnselectShop(BuildContext context) => context
    ..read<ShopsBloc>().add(const ShopsEvent.unselectShop())
    ..read<MapCubit>().setDefaultLocation();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppInsets.kSymmetricH16,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShopName(name: shop.name),
                      AppBoxes.kBoxV24,
                      _ShopSchedule(schedule: shop.schedule),
                      AppBoxes.kBoxV16,
                      const _ShopPhone(),
                      AppBoxes.kBoxV48,
                    ],
                  ),
                ),
                CloseModalButton(onTap: () => _onUnselectShop(context)),
              ],
            ),
            AppTextButton.primary(
              text: t.shops.buildRoute,
              onTap: () => _onBuildMapRoute(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopPhone extends StatelessWidget {
  const _ShopPhone();

  @override
  Widget build(BuildContext context) {
    final phone = context.read<AddressesBloc>().state.phone;

    return Row(
      children: [
        Assets.icons.phone.svg(
          width: AppSizes.kIconMedium,
          height: AppSizes.kIconMedium,
        ),
        AppBoxes.kBoxH8,
        Text(
          phone,
          style: context.textStyle.textTypo.tx2Medium.withColor(
            context.colors.textColors.main,
          ),
        ),
      ],
    );
  }
}

class _ShopSchedule extends StatelessWidget {
  const _ShopSchedule({
    required this.schedule,
  });

  final String schedule;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppInsets.kSymmetricV12,
          child: Assets.icons.time.svg(
            width: AppSizes.kIconMedium,
            height: AppSizes.kIconMedium,
          ),
        ),
        AppBoxes.kBoxH8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  t.shops.workSchedule,
                  style: context.textStyle.textTypo.tx2Medium.withColor(
                    context.colors.textColors.main,
                  ),
                ),
              ],
            ),
            Text(
              schedule,
              style: context.textStyle.descriptionTypo.des3.withColor(
                context.colors.textColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShopName extends StatelessWidget {
  const _ShopName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final city = context.read<AddressesBloc>().state.cityFullName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBoxes.kBoxV12,
        Text(
          name,
          style: context.textStyle.textTypo.tx1SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppBoxes.kBoxV2,
        Text(
          city,
          style: context.textStyle.descriptionTypo.des3.withColor(
            context.colors.textColors.secondary,
          ),
        ),
      ],
    );
  }
}
