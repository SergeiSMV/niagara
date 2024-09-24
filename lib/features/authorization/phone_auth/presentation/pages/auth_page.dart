import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/auth_later_button.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/get_code_widget.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/phone_number_field.dart';
import 'package:niagara_app/features/authorization/phone_auth/presentation/widgets/privacy_policy_text_button.dart';

/// Страница авторизации [AuthPage] с вводом номера телефона и кнопкой
/// "Получить код", а также ссылками на политику конфиденциальности.
@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  void _navigateToOTP(BuildContext context, String phone) =>
      context.pushRoute(OTPRoute(phoneNumber: phone));

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => state.maybeWhen(
        getCode: (phoneNumber) => _navigateToOTP(context, phoneNumber),
        orElse: () => null,
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      PhoneNumberField(formKey: formKey),
                      const AuthLaterButton(),
                    ],
                  ),
                  Column(
                    children: [
                      const PrivacyPolicyTextButtons(),
                      AppBoxes.kHeight12,
                      GetCodeWidget(formKey: formKey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
