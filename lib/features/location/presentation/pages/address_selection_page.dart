import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class AddressSelectionPage extends StatelessWidget {
  const AddressSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: t.locations.deliveryAddress,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {},
            child: Assets.icons.location
                .svg(width: AppConst.kIconLarge, height: AppConst.kIconLarge)
                .paddingSymmetric(horizontal: AppConst.kPaddingMax),
          ),
        ],
      ),
    );
  }
}
