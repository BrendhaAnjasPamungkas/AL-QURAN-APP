import 'package:get/get.dart';
import '../../domain/entities/surah.dart';
import '../../domain/usecases/get_all_surah.dart';
import 'package:get_storage/get_storage.dart'; 


class HomeController extends GetxController {
  final GetAllSurah getAllSurah;
  HomeController(this.getAllSurah);

  // Ganti isLoading menjadi RxBool
  final RxBool isLoading = true.obs; 
  var surahList = <Surah>[].obs;

  final box = GetStorage();
  var lastReadSurah = {}.obs;

  // Hapus onInit dan panggil fetchSurah dari constructor
  // Ini memastikan data langsung diambil saat controller pertama kali dibuat
  // bahkan saat lazy singleton.
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchSurah();
  //   getLastRead();
  // }

  Future<void> fetchSurah() async {
    print("CONTROLLER: Memulai fetchSurah()...");
    isLoading.value = true;
    try {
      final surahs = await getAllSurah.execute();
      surahList.assignAll(surahs);
      print("CONTROLLER: Berhasil mendapatkan ${surahs.length} surah.");
    } catch (e) {
      print("Error saat fetchSurah: $e");
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengambil data dari server.");
    } finally {
      isLoading.value = false;
      print("CONTROLLER: fetchSurah() selesai, isLoading di-set ke false.");
    }
  }

  void getLastRead() {
    final surahNomor = box.read('last_read_surah_nomor');
    if (surahNomor != null) {
      print("Mencoba membaca Last Read. Nama Surah: ${box.read('last_read_surah_nama')}");
      lastReadSurah.value = {
        'nomor': surahNomor,
        'nama': box.read('last_read_surah_nama') ?? 'Tidak Diketahui',
        'ayat': box.read('last_read_ayat_nomor') ?? 1,
      };
    }
  }
}