import 'package:flutter/material.dart';

void main() {
  runApp(const BiodataApp());
}

class BiodataApp extends StatelessWidget {
  const BiodataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Biodata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BiodataScreen(),
    );
  }
}

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
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

  Widget _buildEducationItem({
    required String tahun,
    required String sekolah,
    required String jurusan,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tahun,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            sekolah,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (jurusan.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              jurusan,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill, Color color) {
    return Chip(
      label: Text(
        skill,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color.withOpacity(0.2),
      side: BorderSide(color: color.withOpacity(0.3)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildHobbyItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizationItem({
    required String posisi,
    required String organisasi,
    required String periode,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posisi,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  organisasi,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  periode,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BIODATA DIRI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan foto profil
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue[900]!,
                    Colors.blue[700]!,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Ergi Aditya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Mahasiswa Sistem Informasi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            // Data Pribadi - Warna Hijau
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.green[200]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_pin,
                        color: Colors.green[800],
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'DATA PRIBADI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInfoItem(
                    icon: Icons.phone,
                    label: 'No. Telepon',
                    value: '+62 812-3456-7890',
                    color: Colors.green,
                  ),
                  _buildInfoItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'ergi@email.com',
                    color: Colors.green,
                  ),
                  _buildInfoItem(
                    icon: Icons.cake,
                    label: 'Tanggal Lahir',
                    value: '23 Desember 2004',
                    color: Colors.green,
                  ),
                  _buildInfoItem(
                    icon: Icons.transgender,
                    label: 'Jenis Kelamin',
                    value: 'Laki-laki',
                    color: Colors.green,
                  ),
                  _buildInfoItem(
                    icon: Icons.location_on,
                    label: 'Alamat',
                    value: 'perumahan amanah sejahterah',
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            
            // Pendidikan - Warna Orange
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange[200]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.orange[800],
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'PENDIDIKAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildEducationItem(
                    tahun: '2023',
                    sekolah: 'UIN JAMBI',
                    jurusan: 'SISTEM INFORMASI',
                    color: Colors.orange,
                  ),
                  _buildEducationItem(
                    tahun: '2020 - 2023',
                    sekolah: 'SMA Negeri 3 NIPAH PANJANG',
                    jurusan: 'IPS',
                    color: Colors.orange,
                  ),
                  _buildEducationItem(
                    tahun: '2017 - 2020',
                    sekolah: 'SMP Negeri 15 PEMUSIRAN',
                    jurusan: '',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            
            // Keahlian - Warna Ungu
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.purple[200]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.code,
                        color: Colors.purple[800],
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'KEAHLIAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildSkillChip('Flutter', Colors.purple),
                      _buildSkillChip('Dart', Colors.purple),
                      _buildSkillChip('Java', Colors.purple),
                      _buildSkillChip('Python', Colors.purple),
                      _buildSkillChip('UI/UX Design', Colors.purple),
                      _buildSkillChip('Firebase', Colors.purple),
                      _buildSkillChip('Git', Colors.purple),
                      _buildSkillChip('Figma', Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
            
            // Hobi - Warna Biru Muda
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.lightBlue[200]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlue.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sports_basketball,
                        color: Colors.lightBlue[800],
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'HOBI & MINAT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHobbyItem(Icons.music_note, 'Musik', Colors.lightBlue),
                      _buildHobbyItem(Icons.sports_basketball, 'Basket', Colors.lightBlue),
                      _buildHobbyItem(Icons.book, 'Membaca', Colors.lightBlue),
                      _buildHobbyItem(Icons.travel_explore, 'Travel', Colors.lightBlue),
                    ],
                  ),
                ],
              ),
            ),
            
            // Pengalaman Organisasi - Warna Merah Muda
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.pink[200]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.groups,
                        color: Colors.pink[800],
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'PENGALAMAN ORGANISASI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildOrganizationItem(
                    posisi: 'ketua bidang',
                    organisasi: 'DEMA FST',
                    periode: '2025',
                    color: Colors.pink,
                  ),
                  _buildOrganizationItem(
                    posisi: 'Anggota',
                    organisasi: 'IKAMI',
                    periode: '2025',
                    color: Colors.pink,
                  ),
                ],
              ),
            ),
            
            // Footer
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.blue[900],
              child: const Center(
                child: Text(
                  '© 2024 Biodata App - Dibuat dengan Flutter',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}