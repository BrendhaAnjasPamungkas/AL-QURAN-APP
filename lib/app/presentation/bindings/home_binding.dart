import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controllers/home_controller.dart';
import '../../data/datasources/quran_remote_data_source.dart';
import '../../data/repositories/quran_repository_impl.dart';
import '../../domain/repositories/quran_repository.dart';
import '../../domain/usecases/get_all_surah.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranRemoteDataSource>(
        () => QuranRemoteDataSourceImpl(client: http.Client()));
    Get.lazyPut<QuranRepository>(
        () => QuranRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => GetAllSurah(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
  }
}