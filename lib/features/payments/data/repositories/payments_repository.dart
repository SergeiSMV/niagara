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
          applicationScheme: ApiConst.kAppScheme,
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
        if (confirmationUrl.isEmpty) return;

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
