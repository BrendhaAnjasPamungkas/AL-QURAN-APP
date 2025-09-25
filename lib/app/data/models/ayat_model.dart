import '../../domain/entities/ayat.dart';
import 'package:equatable/equatable.dart';

class AyatModel extends Equatable {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;

  const AyatModel({ // <-- Pastikan ada 'const' di sini
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) {
    return AyatModel(
      nomorAyat: json['nomor'] ?? 0,
      teksArab: json['ar'] ?? '',
      teksLatin: json['tr'] ?? '',
      teksIndonesia: json['idn'] ?? '',
    );
  }

  Ayat toEntity() => Ayat(
      nomorAyat: nomorAyat,
      teksArab: teksArab,
      teksLatin: teksLatin,
      teksIndonesia: teksIndonesia);

  @override
  List<Object?> get props => [nomorAyat, teksArab, teksLatin, teksIndonesia];
}