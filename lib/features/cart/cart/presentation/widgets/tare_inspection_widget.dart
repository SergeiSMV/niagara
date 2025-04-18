import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../../profile/user/presentation/bloc/user_bloc.dart';

/// Виджет для проверки необходимости отображения сообщения о необходимости
/// проверки тары.
class TareInspectionWidget extends HookWidget {
  const TareInspectionWidget({super.key});

  /// Метод для скрытия сообщения.
  void _onDismiss(ValueNotifier<bool> isVisible) {
    isVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(true);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => state.maybeWhen(
        loaded: (user) => user.ordersCount == 0 && isVisible.value
            ? _InspectorMessageWidget(
                onDismiss: () => _onDismiss(isVisible),
              )
            : const SizedBox.shrink(),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}

/// Виджет сообщения о необходимости проверки тары.
class _InspectorMessageWidget extends StatelessWidget {
  const _InspectorMessageWidget({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.bgCard,
            borderRadius: AppBorders.kCircular8,
          ),
          child: Padding(
            padding: AppInsets.kAll16,
            child: Column(
              children: [
                Text(
                  t.cart.tareInspectionMessage,
                  style: context.textStyle.textTypo.tx2SemiBold.copyWith(
                    color: context.colors.textColors.error,
                  ),
                ),
                AppBoxes.kHeight12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onDismiss,
                      child: Text(
                        t.cart.closeMessage,
                        textAlign: TextAlign.justify,
                        style: context.textStyle.textTypo.tx2SemiBold.copyWith(
                          color: context.colors.textColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
