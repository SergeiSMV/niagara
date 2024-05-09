import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/enums/bonus_level_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

class BonusLevelBackgroundWidget extends StatelessWidget {
  const BonusLevelBackgroundWidget({
    required this.level,
    super.key,
  });

  final BonusLevel level;

  @override
  Widget build(BuildContext context) {
    final backImageWidth = context.screenWidth;
    final backImageHeight =
        (context.screenHeight / AppConst.kCommon4) + kToolbarHeight;

    return level.cardImage.image(
      width: backImageWidth,
      height: backImageHeight,
      fit: BoxFit.cover,
    );
  }
}
