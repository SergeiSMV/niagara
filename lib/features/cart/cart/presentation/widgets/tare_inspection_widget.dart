import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

/// Виджет для проверки необходимости отображения сообщения о необходимости проверки тары.
class TareInspectionWidget extends StatelessWidget {
  const TareInspectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (user) {
            return user.ordersCount == 0
                ? const _InspectorMessageWidget()
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
  const _InspectorMessageWidget();

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
          child: Text(
            t.cart.tareInspectionMessage,
            style: context.textStyle.textTypo.tx2Medium.copyWith(
              color: context.colors.textColors.error,
            ),
          ),
        ),
      ),
    );
  }
}
