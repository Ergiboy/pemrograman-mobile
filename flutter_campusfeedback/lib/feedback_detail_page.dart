import 'package:flutter/material.dart';
import 'model/feedback_item.dart';

class FeedbackDetailPage extends StatelessWidget {
  final FeedbackItem feedback;
  final VoidCallback onDelete;
  
  const FeedbackDetailPage({
    super.key,
    required this.feedback,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Feedback'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context),
            tooltip: 'Hapus Feedback',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan jenis feedback
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    feedback.jenisFeedbackColor.withOpacity(0.2),
                    feedback.jenisFeedbackColor.withOpacity(0.05),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: feedback.jenisFeedbackColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: feedback.jenisFeedbackColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      feedback.jenisFeedbackIcon,
                      color: feedback.jenisFeedbackColor,
                      size: 30,
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feedback.jenisFeedback,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: feedback.jenisFeedbackColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feedback.nama,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${feedback.nim} • ${feedback.fakultas}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Rating Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber.shade600,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              feedback.nilaiKepuasan.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          feedback.ratingText,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Body content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Informasi Mahasiswa
                  _buildSection(
                    context,
                    title: 'Informasi Mahasiswa',
                    icon: Icons.person_outline,
                    children: [
                      _buildInfoRow(label: 'Nama Lengkap', value: feedback.nama),
                      _buildInfoRow(label: 'NIM', value: feedback.nim),
                      _buildInfoRow(label: 'Fakultas', value: feedback.fakultas),
                      _buildInfoRow(label: 'Tanggal Submit', value: feedback.formattedDate),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Fasilitas yang Dinilai
                  _buildSection(
                    context,
                    title: 'Fasilitas yang Dinilai',
                    icon: Icons.assessment_outlined,
                    children: [
                      if (feedback.fasilitas.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: feedback.fasilitas.map((fasilitas) {
                            return Chip(
                              label: Text(fasilitas),
                              backgroundColor: Colors.blue.shade50,
                              side: BorderSide(color: Colors.blue.shade100),
                            );
                          }).toList(),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Tidak ada fasilitas yang dipilih',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Detail Penilaian
                  _buildSection(
                    context,
                    title: 'Detail Penilaian',
                    icon: Icons.star_outline,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Nilai Kepuasan',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        size: 20,
                                        color: index < feedback.nilaiKepuasan.floor()
                                            ? Colors.amber.shade600
                                            : Colors.grey.shade300,
                                      );
                                    }),
                                    const SizedBox(width: 8),
                                    Text(
                                      '(${feedback.nilaiKepuasan.toStringAsFixed(1)}/5.0)',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: feedback.nilaiKepuasan / 5,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getRatingColor(feedback.nilaiKepuasan),
                              ),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              feedback.ratingText,
                              style: TextStyle(
                                color: _getRatingColor(feedback.nilaiKepuasan),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Pesan Tambahan
                  if (feedback.pesanTambahan.isNotEmpty)
                    Column(
                      children: [
                        _buildSection(
                          context,
                          title: 'Pesan Tambahan',
                          icon: Icons.message_outlined,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                feedback.pesanTambahan,
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  
                  // Status Persetujuan
                  _buildSection(
                    context,
                    title: 'Status Persetujuan',
                    icon: Icons.gavel,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: feedback.setujuSyarat
                              ? Colors.green.shade50
                              : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: feedback.setujuSyarat
                                ? Colors.green.shade100
                                : Colors.orange.shade100,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              feedback.setujuSyarat
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: feedback.setujuSyarat
                                  ? Colors.green
                                  : Colors.orange,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedback.setujuSyarat
                                        ? 'Telah menyetujui syarat dan ketentuan'
                                        : 'Belum menyetujui syarat dan ketentuan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: feedback.setujuSyarat
                                          ? Colors.green.shade800
                                          : Colors.orange.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    feedback.setujuSyarat
                                        ? 'Feedback ini valid dan dapat diproses'
                                        : 'Feedback ini belum memiliki persetujuan lengkap',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Tombol Aksi
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Kembali'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showDeleteConfirmation(context),
                          icon: const Icon(Icons.delete),
                          label: const Text('Hapus'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double nilai) {
    if (nilai >= 4.0) return Colors.green;
    if (nilai >= 3.0) return Colors.blue;
    if (nilai >= 2.0) return Colors.orange;
    return Colors.red;
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning,
              color: Colors.orange.shade600,
            ),
            const SizedBox(width: 12),
            const Text('Konfirmasi Hapus'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apakah Anda yakin ingin menghapus feedback dari ${feedback.nama}?',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Aksi ini tidak dapat dibatalkan.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text('Feedback berhasil dihapus'),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}