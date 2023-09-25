import 'package:get_it/get_it.dart';

import '../../movies/data/data source/movie_remote_data_source.dart';
import '../../movies/data/repository/movies_repository.dart';
import '../../movies/domain/repository/base_movies_repository.dart';
import '../../movies/domain/use cases/get_movie_detail_use_case.dart';
import '../../movies/domain/use cases/get_now_playing_movies_use_case.dart';
import '../../movies/domain/use cases/get_popular_movies_use_case.dart';
import '../../movies/domain/use cases/get_recommendation_use_case.dart';
import '../../movies/domain/use cases/get_top_rated_movies_use_case.dart';
import '../../movies/domain/use cases/get_upcoming_movies_use_case.dart';
import '../../movies/presentation/home/controller/cubit/movies_cubit.dart';
import '../../movies/presentation/movie details/controller/cubit/movie_details_cubit.dart';
import '../utils/themes/controller/app_setting_cubit.dart';

GetIt servicesLocator = GetIt.instance;

class ServicesLocator {
  void init() {
    // registerSingleton

    //**

    // Bloc ( registerFactory is creating new object every time)
    //***
    // TODO: THIS IS Bloc

    servicesLocator.registerFactory(() => AppSettingCubit());

    servicesLocator.registerFactory(() => MoviesCubit(
          getNowPlayingMoviesUseCase: servicesLocator(),
          getPopularMoviesUseCase: servicesLocator(),
          getTopRatedMoviesUseCase: servicesLocator(),
          getUpcomingMoviesUseCase: servicesLocator(),
        ));

    servicesLocator.registerFactory(
      () => MovieDetailsCubit(
        getMovieDetailsUSeCase: servicesLocator(),
        getRecommendationUseCase: servicesLocator(),
      ),
    );

    // TODO: THIS IS USE CASES
    servicesLocator.registerLazySingleton(
        () => GetNowPlayingMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(
        () => GetPopularMoviesUseCase(servicesLocator()));

    servicesLocator.registerLazySingleton(
        () => GetTopRatedMoviesUseCase(servicesLocator()));

    servicesLocator
        .registerLazySingleton(() => GetMovieDetailsUSeCase(servicesLocator()));

    servicesLocator.registerLazySingleton(
        () => RecommendationUseCase(baseMoviesRepository: servicesLocator()));

    servicesLocator.registerLazySingleton(() =>
        GetUpcomingMoviesUseCase(baseMoviesRepository: servicesLocator()));

    //   TODO: THIS IS REPOSITORY
    servicesLocator.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(servicesLocator()));
    //   TODO: THIS IS DATASOURCE

    servicesLocator.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource(),
    );
  }
//registerLazySingleton
//  عبارة عن تثبيت مكان التخزين لل object في ال memory وللتاكد من صحة هذا الكلام
// اعمل print للObject.hashCode قبل اضافتة في services locator
// ومن ثم كرر نفس الخطوة بتاعة ال print
// بعد اضافتة الناتج = توحيد كود التجزئة
}
