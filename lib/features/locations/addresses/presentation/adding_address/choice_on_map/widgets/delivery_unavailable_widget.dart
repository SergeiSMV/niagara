import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryUnavailableWidget extends StatelessWidget {
  const DeliveryUnavailableWidget({super.key});

  Future<void> _onTapNumber(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final phone = context.read<AddressesBloc>().state.phone;
    return Container(
      padding: const EdgeInsets.all(AppSizes.kGeneral12),
      margin: AppInsets.kVertical12 + AppInsets.kHorizontal16,
      decoration: BoxDecoration(
        color: context.colors.infoColors.bgRed,
        borderRadius: AppBorders.kCircular12,
      ),
      child: Row(
        children: [
          Assets.icons.closeFilling.svg(
            colorFilter: ColorFilter.mode(
              context.colors.fieldBordersColors.negative,
              BlendMode.srcIn,
            ),
          ),
          AppBoxes.kWidth8,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.locations.addressOutsideDeliveryZone,
                  style: context.textStyle.textTypo.tx2SemiBold,
                ),
                AppBoxes.kHeight4,
                Text(
                  t.locations.addressOutsideDeliveryZoneDescription,
                  style: context.textStyle.descriptionTypo.des3,
                ),
                AppBoxes.kHeight8,
                Text.rich(
                  t.locations.deliveryQuestions(
                    phone: (_) => _buildTextButton(
                      context,
                      text: phone,
                      onTap: () => _onTapNumber(phone),
                    ),
                  ),
                  style: context.textStyle.textTypo.tx2Medium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildTextButton(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
  }) {
    return TextSpan(
      text: text,
      style: context.textStyle.textTypo.tx2Medium.copyWith(
        color: context.colors.infoColors.blue,
        decoration: TextDecoration.underline,
        decorationColor: context.colors.infoColors.blue,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
