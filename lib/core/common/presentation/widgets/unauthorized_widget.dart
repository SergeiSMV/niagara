import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  const AuthorizationWidget({super.key, this.modal = false});

  /// Отображает модальное окно с виджетом авторизации.
  static void showModal(BuildContext outerContext) {
    showModalBottomSheet(
      context: outerContext,
      backgroundColor: outerContext.colors.mainColors.white,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (innerContext) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) => state.maybeWhen(
            otpSuccess: () async {
              await context.maybePop();
              if (outerContext.mounted) {
                _showToast(outerContext);
              }
              return;
            },
            orElse: () => null,
          ),
          child: const AuthorizationWidget(modal: true),
        );
      },
    );
  }

  /// Индикатор того, что виджет отображается внутри модального окна.
  ///
  /// Влияет на размеры и стили.
  final bool modal;

  static void _showToast(BuildContext context) => AppSnackBar.showInfo(
        context,
        title: 'Авторзиация прошла успешно!',
      );

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    final String title = modal ? t.auth.authTitleModal : t.locations.login;
    final String description =
        modal ? t.auth.authDescriptionModal : t.locations.loginDescription;
    final Color descriptionColor = modal
        ? context.colors.textColors.secondary
        : context.colors.textColors.main;

    return Column(
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
                  if (modal) CloseModalButton(onTap: () => context.maybePop()),
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
          const PrivacyPolicyTextButtons(),
          AppBoxes.kHeight12,
        ],
        GetCodeWidget(formKey: formKey),
      ],
    );
  }
}
