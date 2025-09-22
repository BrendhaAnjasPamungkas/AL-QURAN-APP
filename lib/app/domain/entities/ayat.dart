// lib/app/domain/entities/ayat.dart

import 'package:equatable/equatable.dart';

class Ayat extends Equatable {
  final int nomorAyat;
  final String teksArab;
  final String teksLatin;
  final String teksIndonesia;

  const Ayat({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
  });

  @override
  List<Object?> get props => [nomorAyat, teksArab, teksLatin, teksIndonesia];
}