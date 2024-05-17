import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/cubit/address_details_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/widget/address_details_fields_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';

class ApproveAddressWidget extends StatelessWidget {
  const ApproveAddressWidget(
    this.location, {
    super.key,
  });

  final Address location;

  void onApproveAndGoBack(BuildContext context, Address location) {
    context
      ..read<AddressesBloc>().add(AddressesEvent.addAddress(location))
      ..maybePop();
  }

  void editAddress(BuildContext context) =>
      context.read<ChoiceOnMapCubit>().onEditAddress();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressDetailsCubit>(param1: location),
      child: Padding(
        padding: AppInsets.kSymmetricH16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppInsets.kSymmetricV24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location.name,
                    style: context.textStyle.textTypo.tx1SemiBold,
                  ),
                  InkWell(
                    onTap: () => editAddress(context),
                    child: Assets.icons.pen.svg(
                      width: AppSizes.kIconMedium,
                      height: AppSizes.kIconMedium,
                    ),
                  ),
                ],
              ),
            ),
            const AddressDetailsFieldsWidget(),
            BlocBuilder<AddressDetailsCubit, Address>(
              builder: (_, location) => Padding(
                padding: AppInsets.kSymmetricV24,
                child: AppTextButton.primary(
                  text: t.locations.continueButton,
                  onTap: () => onApproveAndGoBack(context, location),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
