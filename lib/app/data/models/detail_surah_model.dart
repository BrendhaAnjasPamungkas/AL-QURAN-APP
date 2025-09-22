// lib/app/data/models/detail_surah_model.dart

import '../../domain/entities/detail_surah.dart';
import 'ayat_model.dart';

class DetailSurahModel extends DetailSurah {
  const DetailSurahModel({
    required super.nomor,
    required super.nama,
    required super.namaLatin,
    required super.jumlahAyat,
    required super.tempatTurun,
    required super.arti,
    required super.deskripsi,
    required super.ayat,
  });

  factory DetailSurahModel.fromJson(Map<String, dynamic> json) =>
      DetailSurahModel(
        nomor: json['nomor'],
        nama: json['nama'],
        namaLatin: json['nama_latin'],
        jumlahAyat: json['jumlah_ayat'],
        tempatTurun: json['tempat_turun'],
        arti: json['arti'],
        deskripsi: json['deskripsi'],
        
        // --- INI BAGIAN YANG DIPERBAIKI ---
        // 1. Kita buat List<AyatModel> dari JSON
        ayat: List<AyatModel>.from(json['ayat'].map((x) => AyatModel.fromJson(x)))
            // 2. Kita ubah List<AyatModel> menjadi List<Ayat>
            .map((model) => model.toEntity()) 
            // 3. Kita jadikan list
            .toList(), 
      );
}