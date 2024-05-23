import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/catalog/presentation/widget/groups_home_widget.dart';
import 'package:niagara_app/features/home/presentation/widgets/notifications_button.dart';
import 'package:niagara_app/features/home/presentation/widgets/static_banners_widget.dart';
import 'package:niagara_app/features/home/presentation/widgets/support_button.dart';
import 'package:niagara_app/features/locations/_common/presentation/widgets/address_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/bonuses_home_widget.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotions_home_widget.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        body: AddressButton(),
        actions: [
          NotificationsButton(),
          SupportButton(),
          AppBoxes.kWidth8,
        ],
      ),
      body: Stack(
        children: [
          _HomeBackgroundColorsWidget(),
          SingleChildScrollView(
            child: Column(
              children: [
                HomeBonusesWidget(),
                StaticBannersWidget(),
                PromotionsHomeWidget(),
                GroupsHomeWidget(),
              ],
            ),
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
    final colors = [
      context.colors.mainColors.bgCard,
      context.colors.mainColors.white,
    ];

    return Column(
      children: List.generate(
        colors.length,
        (index) => Expanded(
          child: SizedBox.expand(
            child: ColoredBox(color: colors[index]),
          ),
        ),
      ),
    );
  }
}
