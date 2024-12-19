import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/string_extension.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';
import 'package:niagara_app/features/profile/user/presentation/bloc/user_bloc.dart';

class OrderRecepientWidget extends StatelessWidget {
  const OrderRecepientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => state.maybeWhen(
        loaded: _RecepientData.new,
        // TODO: Тут как-то иначе должно быть, но ситуации, когда пользователя
        // нет у нас возникнуть не должно.
        orElse: SizedBox.shrink,
      ),
    );
  }
}

class _RecepientData extends StatelessWidget {
  const _RecepientData(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    context.read<OrderCreationCubit>().recipientSet = user.hasRequiredData;

    final String name = user.name;
    final String surname = user.surname;
    final String patronymic = user.patronymic;
    final String phone = user.phone.phoneFormat();

    final bool hasData = name.isNotEmpty;
    final bool hasPhone = phone.isNotEmpty;

    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kTop8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.orderPlacing.recipient,
                style: context.textStyle.textTypo.tx1SemiBold,
              ),
              if (!hasData)
                Padding(
                  padding: AppInsets.kTop4,
                  child: IconButton(
                    onPressed: () =>
                        context.navigateTo(EditProfileRoute(user: user)),
                    icon: Assets.icons.pen.svg(),
                  ),
                ),
            ],
          ),
          if (hasData) ...[
            AppBoxes.kHeight8,
            Text(
              '${surname.isNotEmpty ? '$surname ' : ''}$name $patronymic',
              style: context.textStyle.textTypo.tx2Medium,
            ),
            if (hasPhone) ...[
              AppBoxes.kHeight8,
              Text(
                phone,
                style: context.textStyle.textTypo.tx2Medium,
              ),
            ],
          ] else
            Text(
              t.orderPlacing.nameAndPhone,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                context.colors.textColors.secondary,
              ),
            ),
        ],
      ),
    );
  }
}
