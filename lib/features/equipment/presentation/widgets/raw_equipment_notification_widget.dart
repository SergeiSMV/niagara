import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/equipments_bloc/equipments_bloc.dart';

/// Уведомляющий баннер оборудования на экране с оборудованием
class RawEquipmentNotificationWidget extends StatelessWidget {
  const RawEquipmentNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<EquipmentsBloc, EquipmentsState>(
        builder: (context, state) => state.maybeWhen(
          loaded: (equipments) {
            final hasRawEquipment = equipments.any(
              (equipment) =>
                  equipment.status == CleaningStatuses.cleaningIsRequired,
            );

            return hasRawEquipment
                ? Container(
                    margin: AppInsets.kVertical24 + AppInsets.kHorizontal16,
                    padding: AppInsets.kAll12,
                    decoration: BoxDecoration(
                      borderRadius: AppBorders.kCircular12,
                      color: context.colors.infoColors.lightRed,
                    ),
                    child: Row(
                      children: [
                        Assets.icons.errorIcon.svg(),
                        AppBoxes.kWidth10,
                        Text(
                          t.equipments.doYouHaveRawEquipment,
                          style: context.textStyle.textTypo.tx2SemiBold
                              .withColor(context.colors.textColors.main),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
