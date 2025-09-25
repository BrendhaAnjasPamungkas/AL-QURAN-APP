// lib/injection.dart

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'app/data/datasources/quran_remote_data_source.dart';
import 'app/data/repositories/quran_repository_impl.dart';
import 'app/domain/repositories/quran_repository.dart';
import 'app/domain/usecases/get_all_surah.dart';
import 'app/domain/usecases/get_detail_surah.dart';
import 'app/presentation/controllers/dashboard_controller.dart';
import 'app/presentation/controllers/detail_surah_controller.dart';
import 'app/presentation/controllers/home_controller.dart';
import 'app/presentation/controllers/onboarding_controller.dart';
import 'app/presentation/controllers/surah_search_controller.dart';

final sl = GetIt.instance;

void init() {
  // Controllers
  sl.registerFactory(() => OnboardingController());
  sl.registerFactory(() => DashboardController());
  sl.registerFactory(() => SurahSearchController());
  sl.registerFactory(() => DetailSurahController(sl()));
  sl.registerLazySingleton(() => HomeController(sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAllSurah(sl()));
  sl.registerLazySingleton(() => GetDetailSurah(sl()));

  // Repositories
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<QuranRemoteDataSource>(
    () => QuranRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}