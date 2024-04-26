import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/cubit/address_details_cubit.dart';

class AddressDetailsFieldsWidget extends StatelessWidget {
  const AddressDetailsFieldsWidget({super.key});

  void _onUpdate(
    BuildContext context, {
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) =>
      context.read<AddressDetailsCubit>().updateAddressData(
            flat: flat,
            entrance: entrance,
            floor: floor,
            comment: comment,
          );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppTextField.number(
            label: t.locations.flatOffice,
            onChanged: (flat) => _onUpdate(
              context,
              flat: flat,
            ),
          ),
          AppConst.kCommon12.verticalBox,
          Row(
            children: [
              Expanded(
                child: AppTextField.number(
                  label: t.locations.entrance,
                  onChanged: (entrance) => _onUpdate(
                    context,
                    entrance: entrance,
                  ),
                ),
              ),
              AppConst.kCommon12.horizontalBox,
              Expanded(
                child: AppTextField.number(
                  label: t.locations.floor,
                  onChanged: (floor) => _onUpdate(
                    context,
                    floor: floor,
                  ),
                ),
              ),
            ],
          ),
          AppConst.kCommon12.verticalBox,
          AppTextField.text(
            label: t.locations.addressComment,
            onChanged: (comment) => _onUpdate(
              context,
              comment: comment,
            ),
          ),
          AppConst.kCommon12.verticalBox,
        ],
      );
}
