import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';
import 'package:niagara_app/features/home/presentation/widgets/address_button.dart';

/// Главная страница приложения.
@RoutePage()
class HomePage extends StatelessWidget {
  /// Создает виджет главной страницы.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        titleWidget: const AppBarAddressButton(),
        actions: [
          AppBarActionButton(
            icon: Assets.icons.notifications,
            // TODO(Oleg): Реализовать переход на экран уведомлений
            onTap: () => debugPrint('Notifications'),
          ),
          AppBarActionButton(
            icon: Assets.icons.support,
            // TODO(Oleg): Реализовать переход на экран поддержки
            onTap: () => debugPrint('Support'),
          ),
          AppConst.kPaddingMid.width,
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Page'),
          ],
        ),
      ),
    );
  }
}
