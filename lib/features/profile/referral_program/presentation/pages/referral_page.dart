import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/referral_program/domain/model/referral_description.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/description/referral_bloc.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/referral_code/referral_code_cubit.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/widget/referral_history_widget.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/widget/referral_progress.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/widget/referral_rewards.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/widget/referral_rules.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

@RoutePage()
class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          _Background(),
          _Content(),
        ],
      ),
    );
  }
}

Future<void> _onInvite(BuildContext context) async {
  final bool? authorized = await context.read<UserBloc>().isAuthorized;
  if (authorized == null) {
    return;
  } else if (!authorized && context.mounted) {
    context.pushRoute(const AuthWrapper(children: [AuthRoute()]));
  } else if (context.mounted) {
    context.read<ReferralCodeCubit>().createReferralCode();
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Пустое пространство, нужное, чтобы часть _Background была видна.
          SizedBox(
            height: context.screenWidth * 0.75,
            child: Stack(
              children: [
                Positioned(
                  top: (context.screenWidth * 0.75) * 0.75,
                  right: AppSizes.kGeneral16,
                  child: SizedBox(
                    height: AppSizes.kButtonMedium,
                    width: AppSizes.kButtonMediumWidth,
                    child: GestureDetector(
                      onTap: () => _onInvite(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Описание программы страницы.
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              color: context.colors.mainColors.white,
            ),
            child: Padding(
              padding: AppInsets.kHorizontal16 + AppInsets.kTop24,
              child: BlocBuilder<ReferralBloc, ReferralState>(
                // TODO: Добавить неавторизованное состояние.
                builder: (_, state) => state.maybeWhen(
                  loaded: _Description.new,
                  orElse: AppCenterLoader.new,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description(this.description);

  final ReferralDescription description;

  void _showHistoryModal(BuildContext context) => showModalBottomSheet(
        context: context,
        backgroundColor: context.colors.mainColors.white,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (ctx) => const ReferralHistoryWidget(),
      );

  void _referralStateListener(BuildContext context, ReferralCodeState state) =>
      state.whenOrNull(
        error: () => AppSnackBar.showError(
          context,
          title: t.errors.unknownError.title,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReferralCodeCubit, ReferralCodeState>(
      listener: _referralStateListener,
      child: Column(
        children: [
          RewardsWidget(
            rewardFriend: description.bonusesFriend,
            rewardMe: description.bonusesMe,
          ),
          AppBoxes.kHeight32,
          RulesWidget(
            description: description.description,
            rules: description.items.map((e) => e.text).toList(),
          ),
          AppBoxes.kHeight32,
          ProgressWidget(
            count: description.bonusesFriendCount,
            goal: description.bonusesConditionCount,
            reward: description.bonusesForCount,
          ),
          AppBoxes.kHeight24,
          GestureDetector(
            onTap: () => _showHistoryModal(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.referral.referralHistory,
                  style: context.textStyle.buttonTypo.btn2semiBold.withColor(
                    context.colors.textColors.accent,
                  ),
                ),
                Assets.icons.arrowRight.svg(
                  height: AppSizes.kIconSmall,
                  width: AppSizes.kIconSmall,
                ),
              ],
            ),
          ),
          AppBoxes.kHeight32,
          const _BottomInviteButton(),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.referralBG.image(),
        Positioned(
          bottom: 0,
          child: Assets.images.a3DReferall.image(
            width: context.screenWidth / 2,
          ),
        ),
        Positioned(
          top: AppSizes.kGeneral32,
          left: AppSizes.kGeneral16,
          right: AppSizes.kGeneral16,
          child: Text(
            t.referral.backgroundTitle,
            style: context.textStyle.headingTypo.h2.withColor(
              context.colors.textColors.white,
            ),
          ),
        ),
        Positioned(
          top: (context.screenWidth * 0.75) * 0.75,
          right: AppSizes.kGeneral16,
          child: const SizedBox(
            height: AppSizes.kButtonMedium,
            width: AppSizes.kButtonMediumWidth,
            child: _BackgroundInviteButton(),
          ),
        ),
      ],
    );
  }
}

class _BackgroundInviteButton extends StatelessWidget {
  const _BackgroundInviteButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ReferralCodeCubit>();
    final bool loading = cubit.state.isLoading;

    return AppTextButton.invisible(
      text: loading ? null : t.referral.invite,
      // TODO: Кнопка ничего не делает, т.к. её HitBox недосягаем
      onTap: loading ? null : () {},
    );
  }
}

class _BottomInviteButton extends StatelessWidget {
  const _BottomInviteButton();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ReferralCodeCubit>();
    final bool loading = cubit.state.isLoading;

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kBottom24 + AppInsets.kTop12,
      child: AppTextButton.primary(
        text: loading ? null : t.referral.inviteFriend,
        onTap: loading ? null : () => _onInvite(context),
      ),
    );
  }
}
