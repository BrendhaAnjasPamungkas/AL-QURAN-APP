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
      print("REPO: Memanggil remoteDataSource.getAllSurah()...");
      final surahModels = await remoteDataSource.getAllSurah();
      print("REPO: Berhasil mendapatkan ${surahModels.length} model surah.");
      final entities = surahModels.map((model) => model.toEntity()).toList();
      print("REPO: Berhasil mengubah model ke entity.");
      return entities;
    } catch (e, s) {
      print("TERJADI ERROR DI REPOSITORY: $e");
      print("STACK TRACE: $s");
      throw Exception('Gagal memuat surah dari repository');
    }
  }

  @override
  Future<DetailSurah> getDetailSurah(int surahNumber) async {
    // ... (kode ini bisa dibiarkan dulu)
    try {
      return await remoteDataSource.getDetailSurah(surahNumber);
    } catch (e, s) {
      print("TERJADI ERROR DI REPOSITORY (DETAIL): $e");
      print("STACK TRACE (DETAIL): $s");
      throw Exception('Gagal memuat detail surah dari repository');
    }
  }
}