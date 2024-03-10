// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/use_cases/fetch_movie_use_case.dart' as _i4;
import 'package:taskdimond/home_screen/home_screen_view_model.dart' as _i3;
import 'inject_models/app_module.dart' as _i8;
import 'network/webservice.dart' as _i6;
import 'repositories/home_repo_impl.dart'
as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
    _i1.GetIt get, {
      String? environment,
      _i2.EnvironmentFilter? environmentFilter,
    }) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.HomeScreenViewModel>(
          () => _i3.HomeScreenViewModel(get<_i4.FetchMovieUseCase>()));
  gh.factory<String>(
        () => appModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.lazySingleton<_i5.Dio>(
          () => appModule.dio(get<String>(instanceName: 'BaseUrl')));
  gh.factory<_i6.Webservice>(() => _i6.Webservice(get<_i5.Dio>()));
  gh.factory<_i7.HomeRepoImpl>(() => _i7.HomeRepoImpl(get<_i6.Webservice>()));
  gh.factory<_i4.FetchMovieUseCase>(
          () => _i4.FetchMovieUseCaseImpl(get<_i7.HomeRepoImpl>()));
  return get;
}

class _$AppModule extends _i8.AppModule {}
