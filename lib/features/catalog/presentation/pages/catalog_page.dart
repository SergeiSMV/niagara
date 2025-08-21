import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../promotions/presentation/widgets/promotions_widget.dart';
import '../widget/groups/groups_widget.dart';
import '../widget/search/catalog_search_button_widget.dart';

/// Страница каталога ("Каталог")
///
/// Содержит в себе список групп товаров и список акций
@RoutePage()
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBarWidget(
              actions: [
                // поиск в аппбаре
                CatalogSearchButtonWidget(),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppBoxes.kHeight4,
                  // список акций (баннеры)
                  PromotionsWidget(),
                  AppBoxes.kHeight12,
                  // плитка групп товаров
                  GroupsWidget(),
                ],
              ),
            ),
          ],
        ),
      );
}
