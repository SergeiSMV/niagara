import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/equipments_bloc/equipments_bloc.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/equipment_item_widgets/equipment_item_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/raw_equipment_notification_widget.dart';

/// Экран с оборудованием
@RoutePage()
class EquipmentsPage extends StatelessWidget {
  const EquipmentsPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<EquipmentsBloc>().add(const EquipmentsEvent.getEquipments());

  @override
  Widget build(BuildContext context) {
    _onRefresh(context);

    return Scaffold(
      body: BlocBuilder<EquipmentsBloc, EquipmentsState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              const SliverAppBarWidget(),
              const RawEquipmentNotificationWidget(),
              state.when(
                loading: () =>
                    const SliverToBoxAdapter(child: AppCenterLoader()),
                error: () => SliverToBoxAdapter(
                  child: ErrorRefreshWidget(
                    onRefresh: () => _onRefresh(context),
                  ),
                ),
                loaded: (equipments) => SliverPadding(
                  padding: AppInsets.kHorizontal16,
                  sliver: SliverList.separated(
                    itemCount: equipments.length,
                    itemBuilder: (context, index) => EquipmentItemWidget(
                      equipment: equipments[index],
                    ),
                    separatorBuilder: (_, __) => AppBoxes.kHeight16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
