import 'dart:ui';

import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_statuses.dart';
import 'package:niagara_app/features/payments/data/remote/data_sources/payments_remote_data_source.dart';
import 'package:niagara_app/features/payments/data/remote/mappers/payment_confirmation_mapper.dart';
import 'package:niagara_app/features/payments/domain/model/paument_confirmation_info.dart';
import 'package:niagara_app/features/payments/domain/repositories/payments_repository.dart';
import 'package:yookassa_payments_flutter/yookassa_payments_flutter.dart';

@LazySingleton(as: IPaymentsRepository)
class PaymentsRepository extends BaseRepository implements IPaymentsRepository {
  PaymentsRepository(
    super._logger,
    super._networkInfo,
    this._paymentsRDS,
  );

  /// Источник данных о платежах с сервера.
  final IPaymentsRemoteDataSource _paymentsRDS;

  @override
  Failure get failure => const PaymentsRepositoryFailure();

  @override
  Future<Either<Failure, String?>> startTokenization({
    required String clientApplicationKey,
    required String shopId,
    required PaymentMethod paymentMethod,
    required String amountRub,
    required String title,
    required String subtitle,
    String? customerId,
  }) =>
      execute(() async {
        final tokenizationData = TokenizationModuleInputData(
          clientApplicationKey: clientApplicationKey,
          title: title,
          subtitle: subtitle,
          amount: Amount(value: amountRub, currency: Currency.rub),
          savePaymentMethod: SavePaymentMethod.userSelects,
          isLoggingEnabled: true,
          shopId: shopId,
          customerId: customerId,
          tokenizationSettings:
              TokenizationSettings(PaymentMethodTypes([paymentMethod])),
          applicationScheme: 'cordova://',
        );

        final TokenizationResult result =
            await YookassaPaymentsFlutter.tokenization(tokenizationData);

        if (result is SuccessTokenizationResult) {
          return result.token;
        } else if (result is CanceledTokenizationResult) {
          return null;
        } else {
          throw failure;
        }
      });

  @override
  Future<Either<Failure, PaymentConfirmationInfo>> getConfirmationUrl({
    required String orderId,
    required String paymentToken,
  }) =>
      execute(
        () => _paymentsRDS
            .getConfirmationUrl(
              orderId: orderId,
              paymentToken: paymentToken,
            )
            .fold(
              (failure) => throw failure,
              (dto) => dto.toModel(),
            ),
      );

  @override
  Future<Either<Failure, void>> startConfirmation({
    required String confirmationUrl,
    required String clientApplicationKey,
    required String shopId,
    required PaymentMethod paymentMethod,
  }) =>
      execute(() async {
        await YookassaPaymentsFlutter.confirmation(
          confirmationUrl,
          paymentMethod,
          clientApplicationKey,
          shopId,
        );
      });

  @override
  Future<Either<Failure, PaymentStatus>> getPaymentStatus({
    required String orderId,
  }) =>
      execute(
        () => _paymentsRDS.getPaymentStatus(orderId: orderId).fold(
              (failure) => throw failure,
              (status) => status,
            ),
      );
}

class MockPaymentsRepository {
  final String clientApplicationKey =
      'test_MzQwNDM3ZGuc7HP8zxGAphXDtp75cgcpoAfUuPvFSC4';
  final amount = Amount(value: '500.50', currency: Currency.rub);
  final String shopId = '340437';

  Future<String?> startTokenaztion() async {
    final tokenizationData = TokenizationModuleInputData(
      customizationSettings: const CustomizationSettings(
        Color(0xFF044B75),
      ),
      clientApplicationKey: clientApplicationKey,
      title: 'Эту строчку пишем мы - заголовок',
      subtitle:
          'Эту строчку тоже пишем мы - описание. Оно может быть чуть подлиннее, lorem ipsum blah blah blah',
      amount: amount,
      savePaymentMethod: SavePaymentMethod.on,
      isLoggingEnabled: true,
      shopId: shopId,
      applicationScheme: 'cordova://',
      tokenizationSettings: const TokenizationSettings(
        PaymentMethodTypes([
          PaymentMethod.sbp,
          PaymentMethod.bankCard,
          PaymentMethod.sberbank,
        ]),
      ),
    );

    final result = await YookassaPaymentsFlutter.tokenization(tokenizationData);

    if (result is SuccessTokenizationResult) {
      print(
        'Tokenization success: ${result.paymentMethodType} ${result.token}',
      );

      return result.token;
    } else if (result is ErrorTokenizationResult) {
      print('Tokenization error: ${result.error}');

      return null;
    } else {
      print('Tokenization canceled: ${result as CanceledTokenizationResult}');

      return null;
    }
  }

  Future<void> confirmPayment(String url, PaymentMethod? paymentMethod) async {
    await YookassaPaymentsFlutter.confirmation(
      url,
      paymentMethod ?? PaymentMethod.bankCard,
      clientApplicationKey,
      shopId,
    );
  }
}
