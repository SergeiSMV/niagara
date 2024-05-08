import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/home/presentation/widgets/notifications_button.dart';
import 'package:niagara_app/features/home/presentation/widgets/support_button.dart';
import 'package:niagara_app/features/locations/_common/presentation/widgets/address_button.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/home_widget/bonuses_home_widget.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        body: const AddressButton(),
        actions: [
          const NotificationsButton(),
          const SupportButton(),
          AppConst.kCommon8.horizontalBox,
        ],
      ),
      backgroundColor: context.colors.mainColors.bgCard,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HomeBonusesWidget(),
          ],
        ),
      ),
    );
  }
}
