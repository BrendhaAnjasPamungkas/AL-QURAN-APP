// lib/app/data/models/surah_model.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/surah.dart';

class SurahModel extends Equatable {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  // Perhatikan, ada field audio full
  final Map<String, String> audioFull;

  const SurahModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audioFull,
  });

  // Factory method untuk konversi dari JSON ke Model
  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        nomor: json['nomor'] ?? 0, // Juga amankan nomor
        // --- UBAH BARIS INI ---
        nama: json['nama'] ?? '', // Jika nama null, beri string kosong
        namaLatin: json['nama_latin'] ?? 'Tanpa Nama', // Amankan juga
        jumlahAyat: json['jumlah_ayat'] ?? 0, // Amankan juga
        tempatTurun: json['tempat_turun'] ?? '', // Amankan juga
        arti: json['arti'] ?? '', // Amankan juga
        deskripsi: json['deskripsi'] ?? '', // Amankan juga
        audioFull: Map<String, String>.from(json['audio_full'] ?? {}),
      );

  // Method untuk konversi dari Model ke Entity
  Surah toEntity() => Surah(
        nomor: nomor,
        nama: nama,
        namaLatin: namaLatin,
        jumlahAyat: jumlahAyat,
        tempatTurun: tempatTurun,
        arti: arti,
        deskripsi: deskripsi,
      );

  @override
  List<Object?> get props => [
        nomor,
        nama,
        namaLatin,
        jumlahAyat,
        tempatTurun,
        arti,
        deskripsi,
        audioFull
      ];
}