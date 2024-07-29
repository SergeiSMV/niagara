import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/equipment_item_widgets/equipment_item_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/raw_equipment_notification_widget.dart';

/// Экран с оборудованием
@RoutePage()
class EquipmentsPage extends StatelessWidget {
  const EquipmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          const RawEquipmentNotificationWidget(),
          SliverPadding(
            padding: AppInsets.kHorizontal16,
            sliver: SliverList.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                return EquipmentItemWidget(
                  status: index == 0
                      ? CleaningStatuses.cleaningIsExpected
                      : (index == 1
                          ? CleaningStatuses.cleaningIsRequired
                          : CleaningStatuses.no),
                );
              },
              separatorBuilder: (_, __) => AppBoxes.kHeight16,
            ),
          ),
        ],
      ),
    );
  }
}
