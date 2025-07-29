import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../bloc/orders_bloc/orders_bloc.dart';
import '../widgets/order_item_widgets/order_item_widget.dart';
import '../widgets/orders_type_buttons_widget.dart';

@RoutePage()
class OrdersPage extends HookWidget {
  const OrdersPage({super.key});

  void _onRefresh(BuildContext context) => context
      .read<OrdersBloc>()
      .add(const OrdersEvent.loading(isForceUpdate: true));

  void _onLoadMore(BuildContext context) =>
      context.read<OrdersBloc>().add(const OrdersEvent.loadMore());

  void _onSetSort(BuildContext context) {
    final sort = context.read<OrdersBloc>().sort;
    context.read<OrdersBloc>().add(OrdersEvent.setSort(sort: sort));
  }

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

    return Scaffold(
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          final hasMore = context.read<OrdersBloc>().hasMore;

          return CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverAppBarWidget(),
              const SliverToBoxAdapter(child: OrdersTypeButtons()),
              state.when(
                loading: (_) =>
                    const SliverToBoxAdapter(child: AppCenterLoader()),
                loaded: (orders, _) => SliverPadding(
                  padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
                  sliver: SliverList.separated(
                    itemCount: orders.length,
                    itemBuilder: (context, index) => OrderItemWidget(
                      order: orders[index],
                      onSortUpdate: () => _onSetSort(context),
                    ),
                    separatorBuilder: (_, __) => AppBoxes.kHeight16,
                  ),
                ),
                error: () => SliverToBoxAdapter(
                  child: ErrorRefreshWidget(
                    onRefresh: () => _onRefresh(context),
                  ),
                ),
              ),
              state.maybeWhen(
                loaded: (_, __) => SliverToBoxAdapter(
                  child: Visibility(
                    visible: hasMore,
                    child: Padding(
                      padding: AppInsets.kAll16,
                      child: Center(
                        child: Assets.lottie.loadCircle.lottie(
                          width: AppSizes.kLoaderBig,
                          height: AppSizes.kLoaderBig,
                        ),
                      ),
                    ),
                  ),
                ),
                orElse: () => const SliverToBoxAdapter(),
              ),
            ],
          );
        },
      ),
    );
  }
}
