// lib/app/presentation/bindings/dashboard_binding.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/dashboard_controller.dart';
import '../controllers/home_controller.dart';
import '../../data/datasources/quran_remote_data_source.dart';
import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/usecases/get_all_surah.dart';
import '../../domain/usecases/get_detail_surah.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // --- TAMBAHKAN SEMUA DEPENDENSI UNTUK HOME DI SINI ---
    Get.lazyPut<QuranRemoteDataSource>(() => QuranRemoteDataSourceImpl(client: http.Client()), fenix: true);
    Get.lazyPut<QuranRepository>(() => QuranRepositoryImpl(remoteDataSource: Get.find()), fenix: true);
    Get.lazyPut(() => GetAllSurah(Get.find()), fenix: true);
    Get.lazyPut(() => GetDetailSurah(Get.find()), fenix: true);
    // ---

    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController(Get.find()));
  }
}