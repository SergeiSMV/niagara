import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()

/// Страница для ввода кода подтверждения.
class OTPPage extends StatelessWidget {
  /// Конструктор страницы для ввода кода подтверждения.
  const OTPPage({
    required this.phoneNumber,
    super.key,
  });

  /// Номер телефона, на который отправлен код подтверждения.
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.auth.confirmNumber),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {},
          child: const Text('Go to OTP page'),
        ),
      ),
    );
  }
}
