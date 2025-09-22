// lib/app/presentation/controllers/detail_surah_controller.dart

import 'package:alquran/app/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../../domain/entities/detail_surah.dart';
import '../../domain/usecases/get_detail_surah.dart';
import 'package:get_storage/get_storage.dart';

class DetailSurahController extends GetxController {
  final GetDetailSurah getDetailSurah;
  final box = GetStorage();

  DetailSurahController(this.getDetailSurah);

  // Gunakan Rxn<T> agar bisa menampung nilai null saat inisialisasi
  var detailSurah = Rxn<DetailSurah>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil nomor surah dari argumen navigasi
    final int surahNumber = Get.arguments;
    fetchDetailSurah(surahNumber);
  }

  void fetchDetailSurah(int surahNumber) async {
    try {
      isLoading(true);
      final result = await getDetailSurah.execute(surahNumber);
      detailSurah.value = result;

      // --- SIMPAN DATA LAST READ DI SINI ---
      box.write('last_read_surah_nomor', result.nomor);
      box.write('last_read_surah_nama', result.namaLatin);
      // Untuk sementara kita simpan Ayah No: 1
      box.write('last_read_ayat_nomor', 1);
      print("Data Last Read DISIMPAN: ${result.namaLatin}");
      Get.find<HomeController>().getLastRead();
          // --- BATAS PENYIMPANAN DATA ---

    } catch (e) {
      Get.snackbar("Error", "Gagal memuat detail surah: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}