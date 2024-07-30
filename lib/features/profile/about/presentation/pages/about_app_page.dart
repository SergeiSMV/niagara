import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_action_tile.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_actions_widget.dart';

@RoutePage()
class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}

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
                redirectRoute: PolicyRoute(
                  html: '',
                  pageTitle: _Title(
                    firstLine: t.profile.aboutApp.policyLine1,
                    secondLine: t.profile.aboutApp.policyLine2,
                  ),
                ),
              ),
              ProfileActionTile(
                title: t.profile.aboutApp.agreement,
                textStyle: tileStyle,
                redirectRoute: PolicyRoute(
                  html: '',
                  pageTitle: _Title(
                    firstLine: t.profile.aboutApp.agreementLine1,
                    secondLine: t.profile.aboutApp.agreementLine2,
                  ),
                ),
              ),
              ProfileActionTile(
                title: t.profile.aboutApp.salesOffer,
                textStyle: tileStyle,
                redirectRoute: PolicyRoute(
                  html: '',
                  pageTitle: _Title(
                    firstLine: t.profile.aboutApp.salesOfferLine1,
                    secondLine: t.profile.aboutApp.salesOfferLine2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.firstLine,
    required this.secondLine,
  });

  final String firstLine;
  final String secondLine;

  @override
  Widget build(BuildContext context) {
    final style = context.textStyle.textTypo.tx1SemiBold;
    return Column(
      children: [
        Text(
          firstLine,
          style: style,
        ),
        Text(
          secondLine,
          style: style,
        ),
      ],
    );
  }
}
