import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotions_state.dart';
part 'promotions_cubit.freezed.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit() : super(const PromotionsState.initial());
}
