import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/cubit/address_details_cubit.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/widget/address_details_fields_widget.dart';

@RoutePage()
class EditLocationPage extends StatelessWidget {
  const EditLocationPage({
    required Location location,
    super.key,
  }) : _location = location;

  final Location _location;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<AddressDetailsCubit>(param1: _location),
        child: Scaffold(
          appBar: const AppBarWidget(),
          body: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _location.name,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ).paddingAll(AppConst.kCommon16),
                  ),
                ],
              ),
              const AddressDetailsFieldsWidget().paddingAll(AppConst.kCommon16),
              const Spacer(),
              BottomShadowWidget(
                child: AppTextButton.accent(
                  text: t.common.save,
                  onTap: () {
                    final location = context.read<AddressDetailsCubit>().state;
                    debugPrint('Location: $location');
                    context.maybePop();
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
