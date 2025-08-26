import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_positions.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/gen/assets.gen.dart';
import '../../../support/presentation/bloc/support_chat_cubit/support_chat_cubit.dart';
import 'action_button.dart';

/// Кнопка-иконка для открытия страницы с чатом службы поддержки.
class SupportButton extends StatelessWidget {
  const SupportButton({Key? key}) : super(key: key);

  /// Открывает страницу с чатом службы поддержки.
  Future<void> _openSupportChat(BuildContext context) =>
      context.read<SupportChatCubit>().openChat();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SupportChatCubit, SupportChatState>(
        buildWhen: (previous, current) => current.maybeWhen(
          unreadCountChanged: (_) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          final cubit = context.read<SupportChatCubit>();
          final unreadCount = cubit.currentUnreadCount;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              AppBarActionButton(
                icon: Assets.icons.support,
                onTap: () async => _openSupportChat(context),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: AppPositions.kMinus8,
                  top: AppPositions.kMinus8,
                  child: Container(
                    width: AppSizes.kGeneral20,
                    height: AppSizes.kGeneral20,
                    decoration: BoxDecoration(
                      color: context.colors.infoColors.red, // Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: context.textStyle.descriptionTypo.des3.copyWith(
                          color: context.colors.textColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
}
