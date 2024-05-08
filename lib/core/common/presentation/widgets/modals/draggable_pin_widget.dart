import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppConst.kCommon4,
        width: AppConst.kCommon32 + AppConst.kCommon8,
        decoration: BoxDecoration(
          color: context.colors.fieldBordersColors.main,
          borderRadius: BorderRadius.circular(AppConst.kCommon2),
        ),
      ),
    ).paddingSymmetric(vertical: AppConst.kCommon8);
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
  double get maxExtent => AppConst.kCommon24;

  @override
  double get minExtent => AppConst.kCommon24;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
