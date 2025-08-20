import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/core.dart';
import '../../domain/models/banner.dart';
import '../../domain/use_cases/get_banners_use_case.dart';

part 'banners_state.dart';
part 'banners_cubit.freezed.dart';

/// Кубит для загрузки баннеров
@injectable
class BannersCubit extends Cubit<BannersState> {
  BannersCubit(this._getBannersUseCase) : super(const BannersState.loading()) {
    getBanners();
  }

  /// Кейс для загрузки баннеров
  final GetBannersUseCase _getBannersUseCase;

  /// Загрузка баннеров
  Future<void> getBanners() async {
    emit(const BannersState.loading());

    await _getBannersUseCase(NoParams()).fold(
      (failure) => emit(BannersState.error(failure.error)),
      (banners) => emit(BannersState.loaded(banners)),
    );
  }
}
