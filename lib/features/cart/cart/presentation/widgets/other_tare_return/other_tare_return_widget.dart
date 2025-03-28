import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/features/cart/cart/domain/models/cart.dart';
import 'package:niagara_app/features/cart/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:niagara_app/features/cart/cart/presentation/widgets/other_tare_return/other_tare_selection_widget.dart';

/// Виджет для выбора тары другого поставщика
class OtherTareReturnWidget extends StatelessWidget {
  const OtherTareReturnWidget({super.key});

  /// Увеличивает количество тары к возврату на 1
  void _onPlus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setOtherReturnTareCount(count: 1));

  /// Уменьшает количество тары к возврату на 1
  void _onMinus(BuildContext context) => context
      .read<CartBloc>()
      .add(const CartEvent.setOtherReturnTareCount(count: -1));

  /// Выбирает все тары к возврату
  void _onAllToggled(BuildContext context) =>
      context.read<CartBloc>().add(const CartEvent.toggleAllOtherTare());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final CartData? data = state.maybeWhen(
          loaded: (cart, _) => cart.cartData,
          loading: (maybeCart, _, __) => maybeCart?.cartData,
          orElse: () => null,
        );

        if (data == null || data.totalTares == 0) {
          return const SizedBox.shrink();
        }

        return OtherTareSelectionWidget(
          amountRub: data.otherTareSum,
          mainSelectedTares: data.tareCount,
          selectedTares: data.otherTareCount,
          totalTares: data.totalTares,
          onPlus: () => _onPlus(context),
          onMinus: () => _onMinus(context),
          onAllToggled: () => _onAllToggled(context),
          taraNotation: data.taraNotation,
        );
      },
    );
  }
}
