import 'package:get/get.dart';
import '../../domain/entities/surah.dart';
import '../../domain/usecases/get_all_surah.dart';
import 'package:get_storage/get_storage.dart'; 

class HomeController extends GetxController {
  final GetAllSurah getAllSurah;
  final box = GetStorage();

  HomeController(this.getAllSurah);

  var surahList = <Surah>[].obs;
  var isLoading = true.obs;
  var lastReadSurah = {}.obs;
  

  @override
  void onInit() {
    fetchSurah();
    getLastRead();
    super.onInit();
  }

  void getLastRead() {
    // Deklarasikan variabelnya terlebih dahulu
    final surahNomor = box.read('last_read_surah_nomor');
    final surahNama = box.read('last_read_surah_nama'); // <-- Pindahkan ini ke atas

    // Baru gunakan di dalam print
    print("Mencoba membaca Last Read. Nama Surah: $surahNama");
    
    if (surahNomor != null) {
      lastReadSurah.value = {
        'nomor': surahNomor,
        'nama': surahNama ?? 'Tidak Diketahui',
        'ayat': box.read('last_read_ayat_nomor') ?? 1,
      };
    }
  }

  void fetchSurah() async {
    try {
      isLoading(true);
      var surahs = await getAllSurah.execute();
      surahList.assignAll(surahs);
    } catch (e) {
      // --- TAMBAHKAN BLOK CATCH INI ---
      // Ini akan mencetak errornya di Debug Console
      print("Error saat fetchSurah: $e"); 
      // Tampilkan juga di layar agar pengguna tahu
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengambil data dari server.");
    } finally {
      isLoading(false);
    }
  }
}