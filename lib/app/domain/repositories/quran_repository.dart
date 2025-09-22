// lib/app/domain/repositories/quran_repository.dart

import '../entities/detail_surah.dart'; // <-- Tambahkan import
import '../entities/surah.dart';

abstract class QuranRepository {
  Future<List<Surah>> getAllSurah();
  // Tambahkan kontrak baru
  Future<DetailSurah> getDetailSurah(int surahNumber);
}