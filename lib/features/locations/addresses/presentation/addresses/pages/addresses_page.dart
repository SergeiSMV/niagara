import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/presentation/widgets/bottom_shadow_widget.dart';
import '../../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../../core/common/presentation/widgets/errors/error_refresh_widget.dart';
import '../../../../../../core/common/presentation/widgets/loaders/app_center_loader.dart';
import '../../../../../../core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import '../../../../../../core/common/presentation/widgets/unauthorized_widget.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../../domain/models/address.dart';
import '../bloc/addresses_bloc.dart';
import '../widgets/list_addresses_widget.dart';

/// Страница адресов доставки
@RoutePage()
class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  /// Слушатель состояния [AddressesBloc]
  void _addressesListener(BuildContext context, AddressesState state) {
    state.maybeWhen(
      error: (_, __) => AppSnackBar.showError(
        context,
        title: t.common.errorOccured,
      ),
      orElse: () {},
    );
  }

  /// Обновляет список адресов
  void _onRefresh(BuildContext context) =>
      context.read<AddressesBloc>().add(const AddressesEvent.loadAddresses());

  @override
  Widget build(BuildContext context) {
    _onRefresh(context);
    return SafeArea(
      child: BlocListener<AddressesBloc, AddressesState>(
        listener: _addressesListener,
        child: BlocBuilder<AddressesBloc, AddressesState>(
          buildWhen: (prev, current) => prev != current,
          builder: (_, state) => state.when(
            initial: SizedBox.shrink,
            loading: AppCenterLoader.new,
            loaded: (_, addresses) => _Loaded(addresses),
            unauthorized: (_) =>
                const AuthorizationWidget(manageRedirect: true),
            error: (_, addresses) =>
                addresses != null ? _Loaded(addresses) : const _Error(),
          ),
        ),
      ),
    );
  }
}

/// Виджет загруженных адресов
class _Loaded extends StatelessWidget {
  const _Loaded(this.addresses);

  /// Список адресов
  final List<Address> addresses;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppBoxes.kHeight48,
          Expanded(
            child: ListAddressesWidget(
              addresses: addresses.reversed.toList(),
            ),
          ),
          BottomShadowWidget(
            child: AppTextButton.primary(
              text: t.common.save,
              onTap: () => context.maybePop(),
            ),
          ),
        ],
      );
}

/// Виджет ошибки загрузки адресов
class _Error extends StatelessWidget {
  const _Error();

  void _onRefresh(BuildContext context) =>
      context.read<AddressesBloc>().add(const AddressesEvent.loadAddresses());

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ErrorRefreshWidget(
              error: t.locations.errorLoad,
              onRefresh: () => _onRefresh(context),
            ),
          ),
        ],
      );
}
