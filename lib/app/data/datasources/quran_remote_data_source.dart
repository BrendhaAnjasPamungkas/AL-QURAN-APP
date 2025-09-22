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
    final response = await client.get(Uri.parse('$_baseUrl/surah'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => SurahModel.fromJson(json)).toList();
    } else {
      // --- TAMBAHKAN PRINT DI SINI UNTUK MELIHAT DETAIL KEGAGALAN ---
      print("Gagal terhubung ke API. Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      // ---
      throw Exception('Failed to load surah');
    }
  }

// ... (sisa kode)

  // Implementasi method baru
  @override
  Future<DetailSurahModel> getDetailSurah(int surahNumber) async {
    final response = await client.get(Uri.parse('$_baseUrl/surah/$surahNumber'));

    if (response.statusCode == 200) {
      // API ini mengembalikan objek tunggal, bukan list
      final Map<String, dynamic> data = json.decode(response.body);
      return DetailSurahModel.fromJson(data);
    } else {
      throw Exception('Failed to load detail surah');
    }
  }
}