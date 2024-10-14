import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
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
    if (shops.isEmpty || true) {
      return Center(
        child: Text(
          t.shops.noShops,
          style: context.textStyle.headingTypo.h2,
        ),
      );
    }

    return SliverList.separated(
      itemCount: shops.length + 1,
      itemBuilder: (_, index) {
        if (index == shops.length) {
          return AppBoxes.kHeight12;
        } else {
          final shop = shops[index];
          return ShopTileWidget(shop: shop);
        }
      },
      separatorBuilder: (_, __) => const ListSeparatorWidget(),
    );
  }
}
