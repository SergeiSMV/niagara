import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_draft_info_dto.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';

extension TokenizationDataMapper on TokenizationDataDto {
  TokenizationData toModel() => TokenizationData(
        orderId: orderId,
        shopId: shopId,
        applicationKey: applicationKey,
        title: title,
        description: description,
        customerId: customerId,
        price: price.toString(),
        paymentMethod: PaymentMethod.fromString(paymentMethod),
      );
}
