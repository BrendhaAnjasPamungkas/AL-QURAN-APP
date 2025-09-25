// lib/app/data/datasources/quran_remote_data_source.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/detail_surah_model.dart'; // <-- Tambahkan import ini
import '../models/surah_model.dart';

abstract class QuranRemoteDataSource {
  Future<List<SurahModel>> getAllSurah();
  // Tambahkan method baru di sini
  Future<DetailSurahModel> getDetailSurah(int surahNumber);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final http.Client client;
  final String _baseUrl = "https://quran-api.santrikoding.com/api";

  QuranRemoteDataSourceImpl({required this.client});

// lib/app/data/datasources/quran_remote_data_source.dart

// ... (kode lainnya di file ini)

  @override
  Future<List<SurahModel>> getAllSurah() async {
    try {
      final response = await client
          .get(Uri.parse('$_baseUrl/surah'))
          // --- TAMBAHKAN TIMEOUT DI SINI ---
          .timeout(const Duration(seconds: 10)); 

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => SurahModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat surah. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Menangkap error timeout atau error lainnya
      throw Exception('Tidak dapat terhubung ke server.');
    }
  }


  // Implementasi method baru
   @override
  Future<DetailSurahModel> getDetailSurah(int surahNumber) async {
    try {
      final response = await client
          .get(Uri.parse('$_baseUrl/surah/$surahNumber'))
          // --- TAMBAHKAN TIMEOUT DI SINI ---
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return DetailSurahModel.fromJson(data);
      } else {
        throw Exception('Gagal memuat detail surah');
      }
    } catch (e) {
      // Menangkap error timeout atau error lainnya
      throw Exception('Tidak dapat terhubung ke server.');
    }
  }
}