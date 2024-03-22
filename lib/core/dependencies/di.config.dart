// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:niagara_app/core/core.dart' as _i15;
import 'package:niagara_app/core/router/app_router.dart' as _i5;
import 'package:niagara_app/core/router/routers/cart_routes.dart' as _i7;
import 'package:niagara_app/core/router/routers/catalog_routes.dart' as _i8;
import 'package:niagara_app/core/router/routers/home_routes.dart' as _i10;
import 'package:niagara_app/core/router/routers/profile_routes.dart' as _i11;
import 'package:niagara_app/core/router/routers/shops_routes.dart' as _i12;
import 'package:niagara_app/core/theme/app_colors.dart' as _i3;
import 'package:niagara_app/core/theme/app_theme.dart' as _i6;
import 'package:niagara_app/core/utils/logger/logger.dart' as _i4;
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart' as _i14;
import 'package:talker_flutter/talker_flutter.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AppColors>(() => const _i3.AppColors());
    gh.lazySingleton<_i4.AppLogger>(() => appModule.appLogger);
    gh.singleton<_i5.AppRouter>(() => _i5.AppRouter());
    gh.singleton<_i6.AppTheme>(() => _i6.AppTheme());
    gh.singleton<_i7.CartRouters>(() => _i7.CartRouters());
    gh.singleton<_i8.CatalogRouters>(() => _i8.CatalogRouters());
    gh.lazySingleton<_i9.Dio>(() => appModule.dio);
    gh.singleton<_i10.HomeRouters>(() => _i10.HomeRouters());
    gh.singleton<_i11.ProfileRouters>(() => _i11.ProfileRouters());
    gh.singleton<_i12.ShopsRouters>(() => _i12.ShopsRouters());
    gh.lazySingleton<_i13.Talker>(() => appModule.talker);
    gh.lazySingleton<_i14.TalkerBlocObserver>(
        () => appModule.talkerBlocObserver);
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
