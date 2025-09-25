import '../../domain/entities/detail_surah.dart';
import 'ayat_model.dart';

class DetailSurahModel extends DetailSurah {
  const DetailSurahModel({ // <-- Pastikan ada 'const' di sini
    required super.nomor,
    required super.nama,
    required super.namaLatin,
    required super.jumlahAyat,
    required super.tempatTurun,
    required super.arti,
    required super.deskripsi,
    required super.ayat,
  });

  factory DetailSurahModel.fromJson(Map<String, dynamic> json) {
    return DetailSurahModel(
      nomor: json['nomor'],
      nama: json['nama'],
      namaLatin: json['nama_latin'],
      jumlahAyat: json['jumlah_ayat'],
      tempatTurun: json['tempat_turun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      ayat: List<AyatModel>.from(json['ayat'].map((x) => AyatModel.fromJson(x)))
          .map((model) => model.toEntity())
          .toList(),
    );
  }
}