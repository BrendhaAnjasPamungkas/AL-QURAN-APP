import '../entities/surah.dart';
import '../repositories/quran_repository.dart';

class GetAllSurah {
  final QuranRepository repository;

  GetAllSurah(this.repository);

  Future<List<Surah>> execute() {
    return repository.getAllSurah();
  }
}