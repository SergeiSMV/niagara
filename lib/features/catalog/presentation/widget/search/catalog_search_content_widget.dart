import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/catalog_search_bloc/catalog_search_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/search_app_bar_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/search_content_widget.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/sort_and_count_widget.dart';

class CatalogSearchContentWidget extends HookWidget {
  const CatalogSearchContentWidget({super.key});

  void _onLoadMore(BuildContext context) => context
      .read<CatalogSearchBloc>()
      .add(const CatalogSearchEvent.loadMore());

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(
      () {
        void onScroll() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            _onLoadMore(context);
          }
        }

        scrollController.addListener(onScroll);
        return () => scrollController.removeListener(onScroll);
      },
      [scrollController],
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: const [
        SliverAppBarWidget(
          automaticallyImplyLeading: false,
          isShowDivider: false,
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
        SliverToBoxAdapter(child: SearchContentWidget()),
      ],
    );
  }
}
