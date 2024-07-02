import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/search_app_bar_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/search_content_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/sort_and_count_widget.dart';

@RoutePage()
class CatalogSearchPage extends StatelessWidget {
  const CatalogSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            automaticallyImplyLeading: false,
            bottom: false,
            body: SearchAppBarWidget(),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            primary: false,
            pinned: true,
            expandedHeight: 30,
            titleSpacing: 0,
            title: SortAndCountWidget(),
          ),
          SliverToBoxAdapter(
            child: SearchContentWidget(
              products: [],
            ),
          ),
        ],
      ),
    );
  }
}
