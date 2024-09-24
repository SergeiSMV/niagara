import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/get_code_widget.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/phone_number_field.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/privacy_policy_text_button.dart';

class UnauthorizedAddressWidget extends StatelessWidget {
  const UnauthorizedAddressWidget({super.key});

  void _navigateToOTP(BuildContext context, String phone) =>
      context.pushRoute(AuthWrapper(children: [OTPRoute(phoneNumber: phone)]));

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => state.maybeWhen(
        getCode: (phoneNumber) => _navigateToOTP(context, phoneNumber),
        orElse: () => null,
      ),
      child: Column(
        children: [
          AppBoxes.kHeight48,
          Padding(
            padding: AppInsets.kHorizontal16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBoxes.kHeight32,
                Text(
                  t.locations.login,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                ),
                AppBoxes.kHeight12,
                Text(
                  t.locations.loginDescription,
                  style: context.textStyle.textTypo.tx1Medium
                      .withColor(context.colors.textColors.main),
                ),
              ],
            ),
          ),
          PhoneNumberField(formKey: formKey),
          const Spacer(),
          const PrivacyPolicyTextButtons(),
          AppBoxes.kHeight12,
          GetCodeWidget(formKey: formKey),
        ],
      ),
    );
  }
}
