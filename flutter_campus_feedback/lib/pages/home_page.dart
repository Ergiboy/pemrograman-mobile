import 'package:flutter/material.dart';
import 'feedback_form.dart';
import 'feedback_list.dart';
import 'summary_page.dart';
import '../widgets/facility_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const FeedbackListPage(),
    const SummaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Feedback'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Daftar Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Ringkasan',
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.school, color: Colors.blue),
              SizedBox(width: 8),
              Text('Tentang Aplikasi'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Campus Feedback v1.0\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Aplikasi untuk mengumpulkan feedback mahasiswa '
                  'terhadap fasilitas dan layanan kampus.\n',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fitur:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                _buildFeatureItem('📝 Form feedback mahasiswa'),
                _buildFeatureItem('⭐ Sistem rating 5 bintang'),
                _buildFeatureItem('📊 Statistik dan ringkasan'),
                _buildFeatureItem('🏫 Multiple fasilitas kampus'),
                _buildFeatureItem('💾 Penyimpanan data sederhana'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  final List<Map<String, dynamic>> _facilities = const [
    {
      'name': 'Perpustakaan',
      'description': 'Koleksi buku, ruang baca, dan fasilitas literasi',
      'icon': Icons.library_books,
      'color': Colors.blue,
    },
    {
      'name': 'Laboratorium',
      'description': 'Lab komputer, sains, dan penelitian',
      'icon': Icons.science,
      'color': Colors.green,
    },
    {
      'name': 'Ruang Kelas',
      'description': 'Kelas belajar, AC, proyektor, dan furniture',
      'icon': Icons.school,
      'color': Colors.orange,
    },
    {
      'name': 'Kantin',
      'description': 'Makanan, minuman, dan kebersihan kantin',
      'icon': Icons.restaurant,
      'color': Colors.red,
    },
    {
      'name': 'Parkiran',
      'description': 'Area parkir kendaraan mahasiswa',
      'icon': Icons.local_parking,
      'color': Colors.purple,
    },
    {
      'name': 'Wi-Fi Kampus',
      'description': 'Jaringan internet dan konektivitas',
      'icon': Icons.wifi,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(
                    Icons.school,
                    size: 64,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kuesioner Kepuasan Mahasiswa',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Berikan masukan Anda untuk meningkatkan fasilitas dan layanan kampus',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Facilities Section
          const Text(
            'Fasilitas Kampus',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pilih fasilitas untuk memberikan penilaian',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          
          // Facilities Grid - TANPA Expanded, dengan shrinkWrap
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: _facilities.length,
            itemBuilder: (context, index) {
              final facility = _facilities[index];
              return FacilityCard(
                facilityName: facility['name'] as String,
                description: facility['description'] as String,
                icon: facility['icon'] as IconData,
                color: facility['color'] as Color,
                onTap: () {
                  _navigateToFeedbackForm(context, facility['name'] as String);
                },
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // Quick Actions Section
          const Text(
            'Aksi Cepat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Quick Actions Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildQuickActionButton(
                icon: Icons.feedback,
                label: 'Feedback Baru',
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackForm()),
                  );
                },
              ),
              _buildQuickActionButton(
                icon: Icons.analytics,
                label: 'Statistik',
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SummaryPage()),
                  );
                },
              ),
              _buildQuickActionButton(
                icon: Icons.list,
                label: 'Lihat Feedback',
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackListPage()),
                  );
                },
              ),
              _buildQuickActionButton(
                icon: Icons.info,
                label: 'Tentang',
                color: Colors.purple,
                onTap: () {
                  _showAboutDialogFromChild(context);
                },
              ),
            ],
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // METHOD-METHOD YANG DIPINDAHKAN KE DALAM CLASS HomeContent

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFeedbackForm(BuildContext context, String facilityName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackForm(initialFacility: facilityName),
      ),
    );
  }

  // Method untuk memanggil showAboutDialog dari child widget
  void _showAboutDialogFromChild(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.school, color: Colors.blue),
              SizedBox(width: 8),
              Text('Tentang Aplikasi'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Campus Feedback v1.0\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Aplikasi untuk mengumpulkan feedback mahasiswa '
                  'terhadap fasilitas dan layanan kampus.\n',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fitur:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                _buildFeatureItemForChild('📝 Form feedback mahasiswa'),
                _buildFeatureItemForChild('⭐ Sistem rating 5 bintang'),
                _buildFeatureItemForChild('📊 Statistik dan ringkasan'),
                _buildFeatureItemForChild('🏫 Multiple fasilitas kampus'),
                _buildFeatureItemForChild('💾 Penyimpanan data sederhana'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Method _buildFeatureItem versi untuk HomeContent
  Widget _buildFeatureItemForChild(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}