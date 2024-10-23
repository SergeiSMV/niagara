import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/home/domain/models/banner.dart';
import 'package:niagara_app/features/home/domain/use_cases/get_banners_use_case.dart';

part 'banners_state.dart';
part 'banners_cubit.freezed.dart';

@injectable
class BannersCubit extends Cubit<BannersState> {
  BannersCubit(this._getBannersUseCase) : super(const BannersState.loading()) {
    getBanners();
  }

  final GetBannersUseCase _getBannersUseCase;

  Future<void> getBanners() async {
    emit(const BannersState.loading());

    await _getBannersUseCase(NoParams()).fold(
      (failure) => emit(BannersState.error(failure.error)),
      (banners) => emit(BannersState.loaded(banners)),
    );
  }
}
