import 'package:niagara_app/features/payments/data/remote/dto/payment_confirmation_dto.dart';
import 'package:niagara_app/features/payments/domain/model/paument_confirmation_info.dart';

extension PaymentConfirmationInfoMapper on PaymentConfirmationDto {
  PaymentConfirmationInfo toModel() => PaymentConfirmationInfo(
        confirmationUrl: confirmationUrl,
        status: status,
        success: success,
      );
}
