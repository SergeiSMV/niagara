import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical8,
      child: Center(
        child: Container(
          height: AppSizes.kGeneral4,
          width: AppSizes.kGeneral32 + AppSizes.kGeneral8,
          decoration: BoxDecoration(
            color: context.colors.fieldBordersColors.main,
            borderRadius: AppBorders.kCircular2,
          ),
        ),
      ),
    );
  }
}

class DraggablePinWidget extends StatelessWidget {
  const DraggablePinWidget({super.key});

  @override
  Widget build(BuildContext context) => const SliverPersistentHeader(
        delegate: _DraggablePinWidget(),
      );
}

class _DraggablePinWidget extends SliverPersistentHeaderDelegate {
  const _DraggablePinWidget();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      const PinWidget();

  @override
  double get maxExtent => AppSizes.kGeneral24;

  @override
  double get minExtent => AppSizes.kGeneral24;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
