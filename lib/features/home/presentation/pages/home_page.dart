import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../catalog/presentation/widget/groups/groups_home_widget.dart';
import '../../../equipment/presentation/widgets/equipment_bunner_widget.dart';
import '../../../locations/_common/presentation/widgets/address_button.dart';
import '../../../new_products/presentation/widget/new_products_home_widget.dart';
import '../../../order_history/presentation/widgets/recent_orders_list_widget.dart';
import '../../../prepaid_water/presentation/widgets/prepaid_water_banner.dart';
import '../../../profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import '../../../profile/bonuses/presentation/widgets/home_widget/bonuses_home_widget.dart';
import '../../../promotions/presentation/widgets/promotions_home_widget.dart';
import '../../../special_poducts/presentation/widget/special_products_home_widget.dart';
import '../../../stories/presentation/widget/stories_home_widget.dart';
import '../widgets/banners_widget.dart';
import '../widgets/home_page_refresh_handler.dart';
import '../widgets/notifications_button.dart';
import '../widgets/support_button.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Обработчик pull-to-refresh
  final _refreshHandler = HomePageRefreshHandler();

  /// Контроллер для скролла списка и pull-to-refresh
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Добавляем слушатель скролла
    _scrollController.addListener(_onScroll);
  }

  /// Обработчик скролла для pull-to-refresh
  Future<void> _onScroll() async {
    /// Получаем позицию скролла
    final position = _scrollController.position;

    // Срабатывает при pull-to-refresh (скролл ниже 50 пикселей)
    if (position.pixels <= -50) _onRefresh();
  }

  /// Обновление данных на главной странице
  Future<void> _onRefresh() async => await _refreshHandler.onRefresh(context);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const AppBarWidget(
          automaticallyImplyLeading: false,
          body: AddressButton(),
          actions: [
            NotificationsButton(),
            AppBoxes.kWidth16,
            SupportButton(),
            AppBoxes.kWidth16,
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          children: const [
            Stack(
              children: [
                _HomeBackgroundColorsWidget(),
                Column(
                  children: [
                    HomeBonusesWidget(),
                    PrepaidWaterBanner(),
                    BannersSliderWidget(),
                  ],
                ),
              ],
            ),
            EquipmentBannerWidget(),
            RecentOrdersListWidget(),
            StoriesHomeWidget(),
            PromotionsHomeWidget(),
            NewProductsHomeWidget(),
            SpecialProductsHomeWidget(),
            GroupsHomeWidget(),
          ],
        ),
      );
}

// TODO(kvbykov): Зарефакторить, ВИП-фон должен быть вшит в виджет для ВИПа.
/// Отрисовывает фон в зависимости от статуса пользователя.
class _HomeBackgroundColorsWidget extends StatelessWidget {
  const _HomeBackgroundColorsWidget();

  @override
  Widget build(BuildContext context) => BlocBuilder<BonusesBloc, BonusesState>(
        builder: (_, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (bonuses, _) => bonuses.level.isVIPStatus
              ? bonuses.level.cardImage.image()
              : Container(
                  height: context.screenHeight / 2,
                  color: context.colors.mainColors.bgCard,
                ),
        ),
      );
}
