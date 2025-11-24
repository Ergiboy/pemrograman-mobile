import 'package:flutter/material.dart';
import '../models/feedback_model.dart';
import '../widgets/facility_card.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({super.key});

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  final List<FeedbackModel> _feedbacks = [
    FeedbackModel(
      id: '1',
      studentName: 'Ahmad Rizki',
      studentId: '123456789',
      facility: 'Perpustakaan',
      rating: 4,
      comments: 'Koleksi buku cukup lengkap, namun perlu penambahan buku terbaru. Ruang baca nyaman dan tenang.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    FeedbackModel(
      id: '2',
      studentName: 'Siti Nurhaliza',
      studentId: '987654321',
      facility: 'Kantin',
      rating: 3,
      comments: 'Harga makanan terjangkau, tapi kebersihan perlu ditingkatkan. Variasi menu cukup baik.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    FeedbackModel(
      id: '3',
      studentName: 'Budi Santoso',
      studentId: '456123789',
      facility: 'Wi-Fi Kampus',
      rating: 2,
      comments: 'Sinyal tidak stabil di beberapa area kampus, terutama di gedung belakang. Kecepatan perlu ditingkatkan.',
      date: DateTime.now(),
    ),
    FeedbackModel(
      id: '4',
      studentName: 'Dewi Lestari',
      studentId: '789456123',
      facility: 'Laboratorium',
      rating: 5,
      comments: 'Fasilitas lab sangat memadai, peralatan lengkap dan terkini. Asisten lab sangat membantu.',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    FeedbackModel(
      id: '5',
      studentName: 'Rizky Pratama',
      studentId: '321654987',
      facility: 'Parkiran',
      rating: 3,
      comments: 'Area parkir cukup luas tapi kurang terlindung dari panas dan hujan. Keamanan perlu ditingkatkan.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  final Map<String, IconData> _facilityIcons = {
    'Perpustakaan': Icons.library_books,
    'Laboratorium': Icons.science,
    'Ruang Kelas': Icons.school,
    'Kantin': Icons.restaurant,
    'Parkiran': Icons.local_parking,
    'Wi-Fi Kampus': Icons.wifi,
    'Layanan Administrasi': Icons.assignment,
    'Fasilitas Olahraga': Icons.sports_soccer,
    'Layanan Kesehatan': Icons.medical_services,
    'Lainnya': Icons.more_horiz,
  };

  final Map<String, Color> _facilityColors = {
    'Perpustakaan': Colors.blue,
    'Laboratorium': Colors.green,
    'Ruang Kelas': Colors.orange,
    'Kantin': Colors.red,
    'Parkiran': Colors.purple,
    'Wi-Fi Kampus': Colors.indigo,
    'Layanan Administrasi': Colors.teal,
    'Fasilitas Olahraga': Colors.deepOrange,
    'Layanan Kesehatan': Colors.pink,
    'Lainnya': Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Feedback'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: _feedbacks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feedback, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada feedback yang diterima',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = _feedbacks[index];
                return _buildFeedbackCard(feedback);
              },
            ),
    );
  }

  Widget _buildFeedbackCard(FeedbackModel feedback) {
    return FacilityCard(
      facilityName: feedback.facility,
      description: feedback.comments,
      icon: _facilityIcons[feedback.facility] ?? Icons.help,
      color: _facilityColors[feedback.facility] ?? Colors.grey,
      rating: feedback.rating,
      onTap: () {
        _showFeedbackDetail(feedback);
      },
    );
  }

  void _showFeedbackDetail(FeedbackModel feedback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Feedback - ${feedback.facility}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nama Mahasiswa'),
                subtitle: Text(feedback.studentName),
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('NIM'),
                subtitle: Text(feedback.studentId),
              ),
              ListTile(
                leading: const Icon(Icons.place),
                title: const Text('Fasilitas'),
                subtitle: Text(feedback.facility),
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rating'),
                subtitle: Text('${feedback.rating}/5 - ${_getRatingText(feedback.rating)}'),
              ),
              ListTile(
                leading: const Icon(Icons.comment),
                title: const Text('Komentar'),
                subtitle: Text(feedback.comments),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Tanggal'),
                subtitle: Text(_formatDate(feedback.date)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Feedback'),
        content: const Text('Fitur filter akan diimplementasi di versi selanjutnya.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1: return 'Sangat Tidak Puas';
      case 2: return 'Tidak Puas';
      case 3: return 'Cukup Puas';
      case 4: return 'Puas';
      case 5: return 'Sangat Puas';
      default: return 'Cukup Puas';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}