import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups/groups_home_widget.dart';
import 'package:niagara_app/features/home/presentation/widgets/notifications_button.dart';
import 'package:niagara_app/features/home/presentation/widgets/static_banners_widget.dart';
import 'package:niagara_app/features/home/presentation/widgets/support_button.dart';
import 'package:niagara_app/features/locations/_common/presentation/widgets/address_button.dart';
import 'package:niagara_app/features/new_products/presentation/widget/new_products_home_widget.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/bonuses_home_widget.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotions_home_widget.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(
            automaticallyImplyLeading: false,
            body: AddressButton(),
            actions: [
              NotificationsButton(),
              AppBoxes.kWidth16,
              SupportButton(),
              AppBoxes.kWidth16,
            ],
          ),
          const SliverToBoxAdapter(
            child: Stack(
              children: [
                _HomeBackgroundColorsWidget(),
                Column(
                  children: [
                    HomeBonusesWidget(),
                    StaticBannersWidget(),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const NewProductsHomeWidget(),
              const PromotionsHomeWidget(),
              const GroupsHomeWidget(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _HomeBackgroundColorsWidget extends StatelessWidget {
  const _HomeBackgroundColorsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        loaded: (bonuses, _) => bonuses.level.isVIPStatus
            ? bonuses.level.cardImage.image()
            : Container(
                height: context.screenHeight / 3,
                color: context.colors.mainColors.bgCard,
              ),
      ),
    );
  }
}
