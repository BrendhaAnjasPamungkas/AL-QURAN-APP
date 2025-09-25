// lib/app/presentation/controllers/detail_surah_controller.dart

import 'home_controller.dart';
import 'package:get/get.dart';
import '../../domain/entities/detail_surah.dart';
import '../../domain/usecases/get_detail_surah.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alquran/injection.dart';

class DetailSurahController extends GetxController {
  final GetDetailSurah getDetailSurah;
  final box = GetStorage();

  DetailSurahController(this.getDetailSurah);

  var detailSurah = Rxn<DetailSurah>();
  var isLoading = true.obs;

  // HAPUS onInit() atau onReady() DARI SINI

  void fetchDetailSurah(int surahNumber) async {
    try {
      isLoading.value = true;
      final result = await getDetailSurah.execute(surahNumber);
      
      if (result != null) {
        detailSurah.value = result;
        box.write('last_read_surah_nomor', result.nomor);
        box.write('last_read_surah_nama', result.namaLatin);
        box.write('last_read_ayat_nomor', 1);
        sl<HomeController>().getLastRead();
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat detail surah: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}