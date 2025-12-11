import 'package:flutter/material.dart';

class FeedbackItem {
  final String id;
  final String nama;
  final String nim;
  final String fakultas;
  final List<String> fasilitas;
  final double nilaiKepuasan;
  final String jenisFeedback;
  final String pesanTambahan;
  final bool setujuSyarat;
  final DateTime tanggal;

  FeedbackItem({
    required this.nama,
    required this.nim,
    required this.fakultas,
    required this.fasilitas,
    required this.nilaiKepuasan,
    required this.jenisFeedback,
    required this.pesanTambahan,
    required this.setujuSyarat,
  })  : id = DateTime.now().millisecondsSinceEpoch.toString(),
        tanggal = DateTime.now();

  // Helper method untuk mendapatkan warna berdasarkan jenis feedback
  Color get jenisFeedbackColor {
    switch (jenisFeedback) {
      case 'Apresiasi':
        return Colors.green;
      case 'Saran':
        return Colors.blue;
      case 'Keluhan':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Helper method untuk mendapatkan icon berdasarkan jenis feedback
  IconData get jenisFeedbackIcon {
    switch (jenisFeedback) {
      case 'Apresiasi':
        return Icons.thumb_up;
      case 'Saran':
        return Icons.lightbulb;
      case 'Keluhan':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  // Konversi ke Map untuk kemudahan penggunaan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'fakultas': fakultas,
      'fasilitas': fasilitas,
      'nilaiKepuasan': nilaiKepuasan,
      'jenisFeedback': jenisFeedback,
      'pesanTambahan': pesanTambahan,
      'setujuSyarat': setujuSyarat,
      'tanggal': tanggal.toIso8601String(),
    };
  }

  // Factory method untuk membuat FeedbackItem dari Map
  factory FeedbackItem.fromMap(Map<String, dynamic> map) {
    return FeedbackItem(
      nama: map['nama'] ?? '',
      nim: map['nim'] ?? '',
      fakultas: map['fakultas'] ?? '',
      fasilitas: List<String>.from(map['fasilitas'] ?? []),
      nilaiKepuasan: (map['nilaiKepuasan'] as num).toDouble(),
      jenisFeedback: map['jenisFeedback'] ?? '',
      pesanTambahan: map['pesanTambahan'] ?? '',
      setujuSyarat: map['setujuSyarat'] ?? false,
    );
  }

  // Method untuk mendapatkan rating bintang
  String get ratingText {
    if (nilaiKepuasan >= 4.5) return 'Sangat Baik';
    if (nilaiKepuasan >= 3.5) return 'Baik';
    if (nilaiKepuasan >= 2.5) return 'Cukup';
    if (nilaiKepuasan >= 1.5) return 'Kurang';
    return 'Buruk';
  }

  // Method untuk mendapatkan emoji berdasarkan rating
  String get ratingEmoji {
    if (nilaiKepuasan >= 4.5) return '⭐⭐⭐⭐⭐';
    if (nilaiKepuasan >= 3.5) return '⭐⭐⭐⭐';
    if (nilaiKepuasan >= 2.5) return '⭐⭐⭐';
    if (nilaiKepuasan >= 1.5) return '⭐⭐';
    return '⭐';
  }

  // Method untuk format tanggal
  String get formattedDate {
    return '${tanggal.day}/${tanggal.month}/${tanggal.year} ${tanggal.hour}:${tanggal.minute.toString().padLeft(2, '0')}';
  }

  // Method untuk menampilkan fasilitas sebagai string
  String get fasilitasText {
    return fasilitas.join(', ');
  }
}