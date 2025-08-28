import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../widgets/auth_later_button.dart';
import '../widgets/get_code_widget.dart';
import '../widgets/marketing_policy_text_button.dart';
import '../widgets/phone_number_field.dart';
import '../widgets/privacy_policy_text_button.dart';

/// Страница авторизации [AuthPage] с вводом номера телефона и кнопкой
/// "Получить код", а также ссылками на политику конфиденциальности.
@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  /// Навигация к странице ввода OTP кода
  void _navigateToOTP(BuildContext context, String phone) =>
      context.navigateTo(OTPRoute(phoneNumber: phone));

  @override
  Widget build(BuildContext context) {
    /// Ключ для формы
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
                      PrivacyPolicyTextButtons(formKey: formKey),
                      AppBoxes.kHeight12,
                      MarketingPolicyTextButton(formKey: formKey),
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
