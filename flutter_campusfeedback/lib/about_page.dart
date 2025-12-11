import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo UIN
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.blue.shade300, width: 2),
              ),
              child: const Icon(
                Icons.account_balance,
                size: 60,
                color: Colors.blue,
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'UIN Sulthan Thaha Saifuddin Jambi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // Informasi Aplikasi
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoItem(
                      icon: Icons.school,
                      label: 'Mata Kuliah',
                      value: 'Pemrograman Perangkat Bergerak',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      icon: Icons.person,
                      label: 'Dosen Pengampu',
                      value: 'Ahmad Nasukha, S.Hum., M.S.I',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      icon: Icons.architecture,
                      label: 'Program Studi',
                      value: 'Sistem Informasi',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      icon: Icons.calendar_today,
                      label: 'Tahun Akademik',
                      value: '2024/2025',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Informasi Pengembang
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pengembang Aplikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDeveloperInfo(
                      'Nama Mahasiswa',
                      'Sistem Informasi - UIN STS Jambi',
                    ),
                    const SizedBox(height: 8),
                    _buildDeveloperInfo(
                      'NIM',
                      '1234567890',
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Kembali ke Beranda'),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Copyright
            const Text(
              '© 2024 flutter_campus_feedback v1.0',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}