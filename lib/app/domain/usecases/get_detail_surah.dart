// lib/app/domain/usecases/get_detail_surah.dart

import '../entities/detail_surah.dart';
import '../repositories/quran_repository.dart';

class GetDetailSurah {
  final QuranRepository repository;

  GetDetailSurah(this.repository);

  Future<DetailSurah> execute(int surahNumber) {
    return repository.getDetailSurah(surahNumber);
  }
}