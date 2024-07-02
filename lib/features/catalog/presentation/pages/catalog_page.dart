import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/catalog_search_button_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/groups_widget.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotions_widget.dart';

@RoutePage()
class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            actions: [
              CatalogSearchButtonWidget(),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                AppBoxes.kHeight4,
                PromotionsWidget(),
                AppBoxes.kHeight12,
                GroupsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
