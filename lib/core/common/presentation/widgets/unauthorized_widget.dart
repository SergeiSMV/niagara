import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/get_code_widget.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/phone_number_field.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/privacy_policy_text_button.dart';

class AuthorizationWidget extends StatelessWidget {
  const AuthorizationWidget({
    super.key,
    this.modal = false,
    this.manageRedirect = false,
  });

  /// Отображает модальное окно с виджетом авторизации.
  static Future<void> showModal(
    BuildContext outerContext, [
    bool manageRedirect = false,
  ]) async {
    showModalBottomSheet(
      context: outerContext,
      backgroundColor: outerContext.colors.mainColors.white,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (innerContext) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => state.maybeWhen(
          otpSuccess: () async {
            await context.maybePop();
            if (outerContext.mounted) {
              // Тост рисуем только в модалке
              _showToast(outerContext);
            }
            return;
          },
          orElse: () => null,
        ),
        child: AuthorizationWidget(
          modal: true,
          manageRedirect: manageRedirect,
        ),
      ),
    );
  }

  /// Индикатор того, что виджет отображается внутри модального окна.
  ///
  /// Влияет на размеры и стили.
  final bool modal;

  /// Если `true`, то после успешной успешного ввода номера телефона виджет сам
  /// возьмет на себя задачу направления пользователя на страницу ввода кода.
  ///
  /// Использовать в случаях, когда виджет используется вне [AutoTabsScaffold],
  /// т.к. над ним уже есть обработчик переходов.
  final bool manageRedirect;

  /// Отображает всплывающее уведомление об успешной авторизации.
  static void _showToast(BuildContext context) =>
      AppSnackBar.showInfo(context, title: t.auth.authSuccess);

  /// Переводит пользователя на экран ввода кода подтверждения.
  Future<void> _navigateToOTPListener(
    BuildContext context,
    AuthState state,
  ) async {
    state.maybeWhen(
      getCode: (phoneNumber) async {
        if (!manageRedirect) return;
        context.navigateTo(OTPRoute(phoneNumber: phoneNumber));
      },
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    final String title = modal ? t.auth.authTitleModal : t.locations.login;
    final String description =
        modal ? t.auth.authDescriptionModal : t.locations.loginDescription;
    final Color descriptionColor = modal
        ? context.colors.textColors.secondary
        : context.colors.textColors.main;

    return BlocListener<AuthBloc, AuthState>(
      listener: _navigateToOTPListener,
      child: Column(
        mainAxisSize: modal ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (!modal) AppBoxes.kHeight48,
          Padding(
            padding: AppInsets.kHorizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBoxes.kHeight32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.textStyle.headingTypo.h3
                          .withColor(context.colors.textColors.main),
                    ),
                    if (modal)
                      CloseModalButton(onTap: () => context.maybePop()),
                  ],
                ),
                AppBoxes.kHeight12,
                Text(
                  description,
                  style: context.textStyle.textTypo.tx1Medium
                      .withColor(descriptionColor),
                ),
              ],
            ),
          ),
          PhoneNumberField(formKey: formKey),
          if (!modal) ...[
            const Spacer(),
            PrivacyPolicyTextButtons(formKey: formKey),
            AppBoxes.kHeight12,
          ],
          GetCodeWidget(formKey: formKey),
        ],
      ),
    );
  }
}
