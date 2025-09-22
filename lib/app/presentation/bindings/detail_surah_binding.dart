// lib/app/presentation/bindings/detail_surah_binding.dart

import 'package:get/get.dart';
import '../../domain/usecases/get_detail_surah.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahBinding extends Bindings {
  @override
  void dependencies() {
    // Kita tidak perlu mendaftarkan Repository atau DataSource lagi
    // karena sudah didaftarkan di HomeBinding dan bersifat permanen (permanent: true by default).
    // Cukup daftarkan use case dan controller yang spesifik untuk halaman ini.
    Get.lazyPut(() => GetDetailSurah(Get.find()));
    Get.lazyPut(() => DetailSurahController(Get.find()));
  }
}