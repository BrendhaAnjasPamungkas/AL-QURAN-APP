// lib/app/presentation/bindings/search_binding.dart

import 'package:get/get.dart';
// UBAH IMPORT DI SINI
import '../controllers/surah_search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // UBAH NAMA CONTROLLER DI SINI
    Get.lazyPut(() => SurahSearchController());
  }
}