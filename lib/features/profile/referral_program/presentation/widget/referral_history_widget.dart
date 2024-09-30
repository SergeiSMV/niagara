import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/bonus_history_tile.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/history/no_bonuses_widget.dart';
import 'package:niagara_app/features/profile/referral_program/presentation/bloc/history/referral_history_cubit.dart';

class ReferralHistoryWidget extends StatelessWidget {
  const ReferralHistoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kBottom16,
      child: Column(
        children: [
          const PinWidget(),
          AppBoxes.kHeight16,
          const _HistoryHeader(),
          AppBoxes.kHeight16,
          BlocBuilder<ReferralHistoryCubit, ReferralHistoryState>(
            builder: (context, state) => state.maybeWhen(
              loading: AppCenterLoader.new,
              loaded: (history, hasMore) => history.isNotEmpty
                  ? Flexible(
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          if (index == history.length - 1) {
                            context.read<ReferralHistoryCubit>().loadMore();
                          }

                          return BonusHistoryTile(
                            title: history[index].friendName,
                            date: history[index].friendDate,
                            count: history[index].friendCount.toDouble(),
                          );
                        },
                        separatorBuilder: (_, __) => Divider(
                          height: 0,
                          color: context.colors.otherColors.separator30,
                          thickness: AppSizes.kGeneral1,
                        ),
                        itemCount: history.length,
                      ),
                    )
                  : EmptyHistoryWidget(
                      title: t.referral.noHistoryTitle,
                      subtitle: t.referral.noHistoryDescription,
                    ),
              orElse: SizedBox.shrink,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t.referral.referralHistory,
          style: context.textStyle.headingTypo.h3,
        ),
        CloseModalButton(
          onTap: () => context.maybePop(),
          transparent: true,
        ),
      ],
    );
  }
}
