import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class DraggablePinWidget extends SliverPersistentHeaderDelegate {
  const DraggablePinWidget();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      Center(
        child: Container(
          height: AppConst.kCommon4,
          width: AppConst.kCommon32 + AppConst.kCommon8,
          decoration: BoxDecoration(
            color: context.colors.fieldBordersColors.main,
            borderRadius: BorderRadius.circular(AppConst.kCommon2),
          ),
        ),
      );

  @override
  double get maxExtent => AppConst.kCommon24;

  @override
  double get minExtent => AppConst.kCommon24;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
