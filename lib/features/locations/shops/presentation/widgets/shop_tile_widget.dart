import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class ShopTileWidget extends StatelessWidget {
  const ShopTileWidget({
    required this.shop,
    super.key,
  });

  final Shop shop;

  void _onTap(BuildContext context, Shop shop) {
    final mapCubit = context.read<MapCubit>();
    final shopsBloc = context.read<ShopsBloc>();
    final point = Point(
      latitude: shop.coordinates.$1,
      longitude: shop.coordinates.$2,
    );

    mapCubit
        .moveCameraToPoint(point: point)
        .whenComplete(() => shopsBloc.add(ShopsEvent.selectShop(shop: shop)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shop.name),
      subtitle: Text(shop.description),
      trailing: Assets.icons.arrowRight.svg(
        width: AppConst.kIconMedium,
        height: AppConst.kIconMedium,
      ),
      onTap: () => _onTap(context, shop),
      titleTextStyle: context.textStyle.textTypo.tx1SemiBold
          .withColor(context.colors.textColors.main),
      subtitleTextStyle: context.textStyle.descriptionTypo.des3.withColor(
        context.colors.textColors.secondary,
      ),
      contentPadding: AppConst.kCommon16.horizontal,
    );
  }
}
