// lib/app/data/datasources/mock_quran_remote_data_source.dart
import '../models/detail_surah_model.dart'; // <-- Tambahkan import ini
import '../models/surah_model.dart';
import 'quran_remote_data_source.dart';


class MockQuranRemoteDataSource implements QuranRemoteDataSource {
  @override
  Future<List<SurahModel>> getAllSurah() async {
    print("MOCK: Memulai pengambilan data bohongan...");
    await Future.delayed(const Duration(seconds: 1));
    print("MOCK: Mengembalikan 2 surah bohongan.");
    return [
      const SurahModel(
        nomor: 1,
        nama: "الفاتحة",
        namaLatin: "Al-Fatihah (Mock)",
        jumlahAyat: 7,
        tempatTurun: "Mekah",
        arti: "Pembukaan",
        deskripsi: "Ini adalah data bohongan.",
        audioFull: {},
      ),
      const SurahModel(
        nomor: 2,
        nama: "البقرة",
        namaLatin: "Al-Baqarah (Mock)",
        jumlahAyat: 286,
        tempatTurun: "Madinah",
        arti: "Sapi Betina",
        deskripsi: "Ini adalah data bohongan.",
        audioFull: {},
      ),
    ];
  }

  @override
  Future<DetailSurahModel> getDetailSurah(int surahNumber) {
    throw UnimplementedError();
  }
}