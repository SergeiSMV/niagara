// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:niagara_app/core/core.dart';
// import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
// import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

// part 'vip_order_state.dart';
// part 'vip_order_cubit.freezed.dart';

// @injectable
// class VipOrderCubit extends Cubit<PaymentMethod?> {
//   VipOrderCubit() : super(null);

//   /// Выбирает метод оплаты.
//   void selectPaymentMethod(PaymentMethod method) {
//     if (method == state) {
//       emit(null);
//       return;
//     }

//     emit(method);
//   }
// }
