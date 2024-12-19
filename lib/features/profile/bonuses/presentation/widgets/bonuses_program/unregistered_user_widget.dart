import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';

class UnregisteredUserWidget extends StatelessWidget {
  const UnregisteredUserWidget({super.key});

  void _goToAuthPage(BuildContext context) =>
      context.pushRoute(const AuthWrapper());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BonusesBloc, BonusesState>(
      builder: (_, state) => state.maybeWhen(
        unauthorized: () => Column(
          children: [
            AppBoxes.kHeight16,
            Text(
              t.bonuses.aboutBonusesProgram.unregistered,
              style: context.textStyle.textTypo.tx2Medium
                  .withColor(context.colors.mainColors.white),
            ),
            AppBoxes.kHeight16,
            AppTextButton.invisible(
              text: t.bonuses.aboutBonusesProgram.signInOrRegister,
              onTap: () => _goToAuthPage(context),
            ),
          ],
        ),
        orElse: SizedBox.shrink,
      ),
    );
  }
}
