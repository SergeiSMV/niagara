import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../core/dependencies/di.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/user_order.dart';
import '../../bloc/order_receipt_cubit.dart/receipt_cubit.dart';

/// Виджет, отображающий чек заказа.
class OrderReceiptWidget extends StatelessWidget {
  const OrderReceiptWidget({required this.order, super.key});

  /// Заказ, для которого отображается чек.
  final UserOrder order;

  /// Загрузка чека заказа.
  void _loadReceipt(BuildContext context, String orderId) =>
      context.read<OrderReceiptCubit>().getOrderReceipt(orderId);

  /// Извлекает URL QR-кода из HTML.
  String? _extractQrCodeUrl(String html) {
    // Ищем URL в background-image
    final regex = RegExp(r"background-image:\s*url\('([^']+)'\)");
    final match = regex.firstMatch(html);
    if (match != null) {
      return match.group(1);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => BlocProvider<OrderReceiptCubit>(
        // ignore: discarded_futures
        create: (_) => getIt<OrderReceiptCubit>()..getOrderReceipt(order.id),
        child: CustomScrollView(
          slivers: [
            SliverAppBarWidget(
              title: '${t.recentOrders.orderNumber}${order.orderNumber}',
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kAll16,
                child: BlocBuilder<OrderReceiptCubit, OrderReceiptState>(
                  builder: (_, state) => state.maybeWhen(
                    loaded: (receipt) => Column(
                      children: [
                        HtmlWidget(receipt.html),
                        _BuildQrCodeWidget(
                          qrCodeUrl: _extractQrCodeUrl(receipt.html),
                        ),
                      ],
                    ),
                    error: () => ErrorRefreshWidget(
                      onRefresh: () => _loadReceipt(context, order.id),
                    ),
                    orElse: AppCenterLoader.new,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

/// Виджет, отображающий QR-код, если он найден в HTML
class _BuildQrCodeWidget extends StatelessWidget {
  const _BuildQrCodeWidget({required this.qrCodeUrl});

  /// URL QR-кода
  final String? qrCodeUrl;

  @override
  Widget build(BuildContext context) => qrCodeUrl != null
      ? Container(
          width: AppSizes.kImageSize150,
          height: AppSizes.kImageSize150,
          margin: AppInsets.kVertical20,
          child: Image.network(
            qrCodeUrl!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              width: AppSizes.kImageSize150,
              height: AppSizes.kImageSize150,
              child: Center(
                child: Text(
                  t.errors.qrCodeError.title,
                  textAlign: TextAlign.center,
                  style: context.textStyle.captionTypo.c2
                      .withColor(context.colors.textColors.main),
                ),
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
