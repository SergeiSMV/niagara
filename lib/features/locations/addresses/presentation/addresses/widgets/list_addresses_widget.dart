import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/widgets/add_new_address_button.dart';

class ListAddressesWidget extends StatelessWidget {
  const ListAddressesWidget({
    required this.addresses,
    super.key,
  });

  final List<Address> addresses;

  void _onEditAddress(BuildContext context, Address address) =>
      context.pushRoute(EditAddressRoute(address: address));

  void _onSetDefault(BuildContext context, Address address) => address.isDefault
      ? null
      : context
          .read<AddressesBloc>()
          .add(AddressesEvent.setDefaultAddress(address));

  SvgGenImage _buildRadioIcon(Address address) => address.isDefault
      ? Assets.icons.radio.radioTrue
      : Assets.icons.radio.radioFalse;

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding:  AppInsets.kSymmetricV12,
        itemCount: addresses.length + 1,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          if (index == addresses.length) return const AddNewAddressButton();

          final address = addresses[index];
          return ListTile(
            contentPadding:  AppInsets.kSymmetricH16,
            leading: _buildRadioIcon(address).svg(
              width: AppSizes.kIconMedium,
              height: AppSizes.kIconMedium,
            ),
            title: Text(
              address.name,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.main),
            ),
            subtitle: address.hasDetails
                ? Text(
                    address.additional,
                    style: context.textStyle.descriptionTypo.des3
                        .withColor(context.colors.textColors.secondary),
                  )
                : null,
            trailing: InkWell(
              onTap: () => _onEditAddress(context, address),
              child: Assets.icons.pen.svg(
                width: AppSizes.kIconMedium,
                height: AppSizes.kIconMedium,
              ),
            ),
            onTap: () => _onSetDefault(context, address),
          ); // выбор
        },
      );
}
