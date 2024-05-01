import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/cubit/address_details_cubit.dart';

class AddressDetailsFieldsWidget extends StatelessWidget {
  const AddressDetailsFieldsWidget({
    Location? location,
    super.key,
  }) : _location = location;

  final Location? _location;

  String? get _flat => _location != null && _location.flat.isNotEmpty 
      ? _location.flat 
      : null;

  String? get _entrance => _location != null && _location.entrance.isNotEmpty
      ? _location.entrance
      : null;

  String? get _floor => _location != null && _location.floor.isNotEmpty 
      ? _location.floor 
      : null;

  String? get _comment => _location != null && _location.description.isNotEmpty
      ? _location.description
      : null;

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
            initialText: _flat,
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
                  initialText: _entrance,
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
                  initialText: _floor,
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
            initialText: _comment,
            onChanged: (comment) => _onUpdate(
              context,
              comment: comment,
            ),
          ),
          AppConst.kCommon12.verticalBox,
        ],
      );
}
