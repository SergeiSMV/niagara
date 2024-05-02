import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class ListSeparatorWidget extends StatelessWidget {
  const ListSeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: AppConst.kCommon2,
      thickness: AppConst.kCommon1,
      indent: AppConst.kCommon16,
      endIndent: AppConst.kCommon16,
      color: context.colors.otherColors.separator30,
    );
  }
}
