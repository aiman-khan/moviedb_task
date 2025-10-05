// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../../features/movies/data/repository/movies_repository_imp.dart'
    as _i714;
import '../../../features/movies/data/source/remote/movies_data_source_imp.dart'
    as _i516;
import '../../../features/movies/domain/data/movies_remote_data_source.dart'
    as _i332;
import '../../../features/movies/domain/repository/movies_repository.dart'
    as _i551;
import '../../../features/movies/domain/usecases/get_upcoming_movies_usecase.dart'
    as _i1010;
import '../../../features/movies/domain/usecases/search_movie_usecase.dart'
    as _i368;
import '../../helpers/network_call_helper/http_network_call_helper_impl.dart'
    as _i336;
import '../../helpers/network_call_helper/network_call_helper.dart' as _i73;
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i974.Logger>(() => _i913.LoggerImp());
    gh.lazySingleton<_i73.NetworkCallHelper>(
      () => _i336.HttpNetworkCallHelperImpl(logger: gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i332.MovieRemoteDataSource>(
      () => _i516.AuthRemoteDataSourceImp(
        logger: gh<_i974.Logger>(),
        networkCallHelper: gh<_i73.NetworkCallHelper>(),
      ),
    );
    gh.lazySingleton<_i551.MovieRepository>(
      () => _i714.MovieRepositoryImpl(
        movieRemoteDataSource: gh<_i332.MovieRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1010.GetUpcomingMoviesUsecase>(
      () => _i1010.GetUpcomingMoviesUsecase(
        movieRepository: gh<_i551.MovieRepository>(),
      ),
    );
    gh.lazySingleton<_i368.SearchMovieUsecase>(
      () => _i368.SearchMovieUsecase(
        movieRepository: gh<_i551.MovieRepository>(),
      ),
    );
    return this;
  }
}
