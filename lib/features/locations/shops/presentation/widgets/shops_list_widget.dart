import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/list_separator_widget.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/presentation/widgets/shop_tile_widget.dart';

class ShopsListWidget extends StatelessWidget {
  const ShopsListWidget({
    required this.shops,
    super.key,
  });
  final List<Shop> shops;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
        itemCount: shops.length + 1,
        itemBuilder: (_, index) {
          if (index == shops.length) {
            return AppConst.kCommon12.verticalBox;
          } else {
            final shop = shops[index];
            return ShopTileWidget(shop: shop);
          }
        },
        separatorBuilder: (_, __) => const ListSeparatorWidget(),
      );
  }
}
