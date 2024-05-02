import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';
import 'package:niagara_app/features/location/presentation/shops/widgets/close_modal_button.dart';
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

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
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
                      AppConst.kCommon24.verticalBox,
                      _ShopSchedule(schedule: shop.schedule),
                      AppConst.kCommon16.verticalBox,
                      const _ShopPhone(),
                      AppConst.kCommon48.verticalBox,
                    ],
                  ),
                ),
                const CloseModalButton(),
              ],
            ),
            AppTextButton.primary(
              text: t.shops.buildRoute,
              onTap: () => _onBuildMapRoute(context),
            ),
          ],
        ).paddingSymmetric(horizontal: AppConst.kCommon16),
      );
}

class _ShopPhone extends StatelessWidget {
  const _ShopPhone();

  @override
  Widget build(BuildContext context) {
    final phone = context.read<LocationsBloc>().state.phone;

    return Row(
      children: [
        Assets.icons.phone.svg(
          width: AppConst.kIconMedium,
          height: AppConst.kIconMedium,
        ),
        AppConst.kCommon8.horizontalBox,
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
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.icons.time
              .svg(
                width: AppConst.kIconMedium,
                height: AppConst.kIconMedium,
              )
              .paddingSymmetric(vertical: AppConst.kCommon2),
          AppConst.kCommon8.horizontalBox,
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

class _ShopName extends StatelessWidget {
  const _ShopName({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final city = context.read<LocationsBloc>().state.cityFullName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppConst.kCommon12.verticalBox,
        Text(
          name,
          style: context.textStyle.textTypo.tx1SemiBold.withColor(
            context.colors.textColors.main,
          ),
        ),
        AppConst.kCommon2.verticalBox,
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
