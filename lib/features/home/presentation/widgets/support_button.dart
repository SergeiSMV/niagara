import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/home/presentation/widgets/action_button.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarActionButton(
      icon: Assets.icons.support,
      // TODO(Oleg): Реализовать переход на экран поддержки
      onTap: () => debugPrint('Support'),
    );
  }
}
