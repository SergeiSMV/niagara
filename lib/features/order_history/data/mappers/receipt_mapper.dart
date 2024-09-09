import 'package:niagara_app/features/order_history/data/remote/dto/receipt_dto.dart';
import 'package:niagara_app/features/order_history/domain/models/order_receipt.dart';

extension OrderReceiptMapper on OrderReceiptDto {
  OrderReceipt toModel() => OrderReceipt(
        html: html,
        orderId: orderId,
      );
}
