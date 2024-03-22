// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:niagara_app/core/core.dart' as _i14;
import 'package:niagara_app/core/router/app_router.dart' as _i4;
import 'package:niagara_app/core/router/routers/cart_routes.dart' as _i6;
import 'package:niagara_app/core/router/routers/catalog_routes.dart' as _i7;
import 'package:niagara_app/core/router/routers/home_routes.dart' as _i9;
import 'package:niagara_app/core/router/routers/profile_routes.dart' as _i10;
import 'package:niagara_app/core/router/routers/shops_routes.dart' as _i11;
import 'package:niagara_app/core/theme/app_theme.dart' as _i5;
import 'package:niagara_app/core/utils/logger/logger.dart' as _i3;
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart' as _i13;
import 'package:talker_flutter/talker_flutter.dart' as _i12;

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
    gh.lazySingleton<_i3.AppLogger>(() => appModule.appLogger);
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.singleton<_i5.AppTheme>(() => _i5.AppTheme());
    gh.singleton<_i6.CartRouters>(() => _i6.CartRouters());
    gh.singleton<_i7.CatalogRouters>(() => _i7.CatalogRouters());
    gh.lazySingleton<_i8.Dio>(() => appModule.dio);
    gh.singleton<_i9.HomeRouters>(() => _i9.HomeRouters());
    gh.singleton<_i10.ProfileRouters>(() => _i10.ProfileRouters());
    gh.singleton<_i11.ShopsRouters>(() => _i11.ShopsRouters());
    gh.lazySingleton<_i12.Talker>(() => appModule.talker);
    gh.lazySingleton<_i13.TalkerBlocObserver>(
        () => appModule.talkerBlocObserver);
    return this;
  }
}

class _$AppModule extends _i14.AppModule {}
