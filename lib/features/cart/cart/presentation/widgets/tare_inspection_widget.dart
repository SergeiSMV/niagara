import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

/// Виджет для проверки необходимости отображения сообщения о необходимости проверки тары.
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
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (user) {
            return user.ordersCount == 0 && isVisible.value
                ? _InspectorMessageWidget(
                    onDismiss: () => _onDismiss(isVisible),
                  )
                : const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

/// Виджет сообщения о необходимости проверки тары.
class _InspectorMessageWidget extends StatelessWidget {
  const _InspectorMessageWidget({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                // textAlign: TextAlign.justify,
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
                      'Закрыть сообщение',
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
}
