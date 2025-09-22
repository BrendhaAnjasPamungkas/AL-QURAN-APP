// lib/app/data/repositories/quran_repository_impl.dart

import '../../domain/entities/detail_surah.dart'; // <-- Tambahkan import
import '../../domain/entities/surah.dart';
import '../../domain/repositories/quran_repository.dart';
import '../datasources/quran_remote_data_source.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  QuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Surah>> getAllSurah() async {
    try {
      final surahModels = await remoteDataSource.getAllSurah();
      return surahModels.map((model) => model.toEntity()).toList();
    } catch (e, s) { // <-- Tambahkan 's' untuk melihat stack trace
      // --- UBAH BAGIAN CATCH INI ---
      print("TERJADI ERROR DI REPOSITORY: $e");
      print("STACK TRACE: $s"); // Stack trace sangat membantu debugging
      // ---
      throw Exception('Failed to load surah from repository');
    }
  }

  // Implementasi method baru
  @override
  Future<DetailSurah> getDetailSurah(int surahNumber) async {
    try {
      return await remoteDataSource.getDetailSurah(surahNumber);
    } catch (e, s) { // <-- Tambahkan 'e' dan 's'
      // --- TAMBAHKAN PRINT DI SINI ---
      print("TERJADI ERROR DI REPOSITORY (DETAIL): $e");
      print("STACK TRACE (DETAIL): $s");
      // ---
      throw Exception('Failed to load detail surah from repository');
    }
  }
}