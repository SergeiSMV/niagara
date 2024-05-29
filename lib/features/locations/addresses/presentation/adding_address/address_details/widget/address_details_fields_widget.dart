import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/cubit/address_details_cubit.dart';

class AddressDetailsFieldsWidget extends StatelessWidget {
  const AddressDetailsFieldsWidget({
    Address? location,
    super.key,
  }) : _location = location;

  final Address? _location;

  bool get _hasFlat => _location != null && _location.flat.isNotEmpty;
  bool get _hasEntrance => _location != null && _location.entrance.isNotEmpty;
  bool get _hasFloor => _location != null && _location.floor.isNotEmpty;
  bool get _hasComment => _location != null && _location.description.isNotEmpty;

  String? get _flat => _hasFlat ? _location!.flat : null;
  String? get _entrance => _hasEntrance ? _location!.entrance : null;
  String? get _floor => _hasFloor ? _location!.floor : null;
  String? get _comment => _hasComment ? _location!.description : null;

  int get _maxShortTextLength => 8;
  int get _maxLongTextLength => 255;

  BaseTextFieldState _state(bool hasData) =>
      hasData ? BaseTextFieldState.disabled : BaseTextFieldState.idle;

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField.number(
          label: t.locations.flatOffice,
          initialText: _flat,
          maxLength: _maxShortTextLength,
          showCounter: false,
          state: _state(_hasFlat),
          onChanged: (flat) => _onUpdate(
            context,
            flat: flat,
          ),
        ),
        AppBoxes.kHeight12,
        Row(
          children: [
            Expanded(
              child: AppTextField.number(
                label: t.locations.entrance,
                initialText: _entrance,
                maxLength: _maxShortTextLength,
                showCounter: false,
                state: _state(_hasEntrance),
                onChanged: (entrance) => _onUpdate(
                  context,
                  entrance: entrance,
                ),
              ),
            ),
            AppBoxes.kWidth12,
            Expanded(
              child: AppTextField.number(
                label: t.locations.floor,
                initialText: _floor,
                maxLength: _maxShortTextLength,
                showCounter: false,
                state: _state(_hasFloor),
                onChanged: (floor) => _onUpdate(
                  context,
                  floor: floor,
                ),
              ),
            ),
          ],
        ),
        AppBoxes.kHeight12,
        AppTextField.text(
          label: t.locations.addressComment,
          initialText: _comment,
          maxLength: _maxLongTextLength,
          onChanged: (comment) => _onUpdate(
            context,
            comment: comment,
          ),
        ),
        AppBoxes.kHeight12,
      ],
    );
  }
}
