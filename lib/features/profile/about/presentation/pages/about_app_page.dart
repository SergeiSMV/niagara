import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../user/presentation/widgets/profile_action_tile.dart';
import '../../../user/presentation/widgets/profile_actions_widget.dart';

/// Страница с информацией о приложении содержащая
/// политику конфиденциальности,
/// пользовательское соглашение,
/// и рекламную и информационную рассылку
///
/// [PolicyType.confidence] - политика конфиденциальности
/// [PolicyType.agreement] - пользовательское соглашение
/// [PolicyType.marketing] - рекламная и информационная рассылка
@RoutePage()
class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(),
            SliverList(
              delegate: SliverChildListDelegate([
                const _Content(),
              ]),
            ),
          ],
        ),
      );
}

/// Виджет списка доступной информации о приложении
///
/// [PolicyType.confidence] - политика конфиденциальности
/// [PolicyType.agreement] - пользовательское соглашение
/// [PolicyType.marketing] - рекламная и информационная рассылка
class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final TextStyle tileStyle = context.textStyle.textTypo.tx1SemiBold;
    final TextStyle descStyle =
        context.textStyle.descriptionTypo.des2.withColor(
      context.colors.textColors.secondary,
    );

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
      child: Column(
        children: [
          Text(t.profile.aboutApp.description, style: descStyle),
          AppBoxes.kHeight12,
          ProfileActionsWidget(
            children: [
              ProfileActionTile(
                title: t.profile.aboutApp.policy,
                textStyle: tileStyle,
                redirectRoute: PolicyRoute(type: PolicyType.confidence),
              ),
              ProfileActionTile(
                title: t.profile.aboutApp.agreement,
                textStyle: tileStyle,
                redirectRoute: PolicyRoute(type: PolicyType.agreement),
              ),
              ProfileActionTile(
                title: t.profile.aboutApp.marketing,
                textStyle: tileStyle,
                redirectRoute: PolicyRoute(type: PolicyType.marketing),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
