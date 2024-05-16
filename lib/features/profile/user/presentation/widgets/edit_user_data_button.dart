import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

class EditUserDataButton extends StatelessWidget {
  const EditUserDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Assets.icons.pen.svg(
        width: AppConst.kIconMedium,
        height: AppConst.kIconMedium,
      ),
    );
  }
}
