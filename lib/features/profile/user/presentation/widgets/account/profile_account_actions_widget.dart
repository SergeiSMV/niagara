import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../../core/utils/constants/app_borders.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../bloc/user_bloc.dart';
import '../profile_action_tile.dart';
import '../profile_actions_widget.dart';

/// Виджет для отображения функционала работы с аккаунтом (удаление, выход).
class ProfileAccountActionsWidget extends StatelessWidget {
  const ProfileAccountActionsWidget({super.key});

  /// Показывает диалог с контентом при выходе из аккаунта или удалении аккаунта
  void _showFloatingDialog(BuildContext context, Widget child) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: AppInsets.kAll8 + AppInsets.kBottom16,
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.kCircular20,
          ),
          child: Padding(
            padding: AppInsets.kAll16 + AppInsets.kVertical8,
            child: child,
          ),
        ),
      );

  /// Удаляет аккаунт
  void _onDelete(BuildContext context) {
    context.read<UserBloc>().add(
          const UserEvent.deleteAccount(),
        );
  }

  /// Выходит из аккаунта
  void _onLogout(BuildContext context) {
    context.read<UserBloc>().add(
          const UserEvent.logout(),
        );
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          // TODO: Уточнить, оставлять ли такое поведение. Технической
          // необходимости в этом больше нет + из-за этого некоторые Bloc'и
          // закрывались и потом не работали.

          // state.maybeWhen(
          //   orElse: () {},
          //   unauthorized: (loggedOut) {
          //     if (loggedOut ?? false) {
          //       context.router.replaceAll([const SplashWrapper()]);
          //     }
          //   },
          // );
        },
        builder: (context, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: (user) => Padding(
            padding: AppInsets.kHorizontal16 + AppInsets.kVertical24,
            child: ProfileActionsWidget(
              children: [
                ProfileActionTile(
                  onTap: () => _showFloatingDialog(
                    context,
                    _LogoutConfirmationWidget(
                      onSubmit: () => _onLogout(context),
                    ),
                  ),
                  title: t.profile.authActions.logoutAction,
                  leadingIcon: Assets.icons.logout,
                ),
                ProfileActionTile(
                  onTap: () => _showFloatingDialog(
                    context,
                    _DeleteAccountConfirmationWidget(
                      onSubmit: () => _onDelete(context),
                    ),
                  ),
                  title: t.profile.authActions.deleteAccountAction,
                  leadingIcon: Assets.icons.delete,
                ),
              ],
            ),
          ),
        ),
      );
}

/// Виджет удаления аккаунта
class _DeleteAccountConfirmationWidget extends StatelessWidget {
  const _DeleteAccountConfirmationWidget({required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.attention3D.image(
            width: 120,
            height: 120,
          ),
          AppBoxes.kHeight24,
          Text(
            t.profile.authActions.deleteConfirmationHeader,
            style: context.textStyle.headingTypo.h3,
          ),
          AppBoxes.kHeight8,
          Text(
            textAlign: TextAlign.center,
            t.profile.authActions.deleteAccountDescription,
            style: context.textStyle.textTypo.tx1Medium
                .withColor(context.colors.textColors.secondary),
          ),
          AppBoxes.kHeight24,
          AppTextButton.primary(
            text: t.profile.authActions.deleteAccountButton,
            onTap: () {
              onSubmit();
              Navigator.of(context).pop();
            },
          ),
          AppBoxes.kHeight16,
          AppTextButton.secondary(
            text: t.profile.authActions.cancelDeletingButton,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}

/// Виджет выхода из аккаунта
class _LogoutConfirmationWidget extends StatelessWidget {
  const _LogoutConfirmationWidget({required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            t.profile.authActions.logoutConfirmationHeader,
            style: context.textStyle.headingTypo.h3,
          ),
          AppBoxes.kHeight24,
          AppTextButton.primary(
            text: t.profile.authActions.logoutButton,
            onTap: () {
              onSubmit();
              Navigator.of(context).pop();
            },
          ),
          AppBoxes.kHeight8,
          AppTextButton.secondary(
            text: t.profile.authActions.logoutLaterButtom,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
}
