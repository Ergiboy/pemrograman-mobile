import 'package:flutter/material.dart';
import '../models/feedback_model.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final List<FeedbackModel> _sampleData = [
    FeedbackModel(
      id: '1',
      studentName: 'Ahmad Rizki',
      studentId: '123456789',
      facility: 'Perpustakaan',
      rating: 4,
      comments: 'Koleksi buku cukup lengkap',
      date: DateTime.now(),
    ),
    FeedbackModel(
      id: '2',
      studentName: 'Siti Nurhaliza',
      studentId: '987654321',
      facility: 'Kantin',
      rating: 3,
      comments: 'Harga makanan terjangkau',
      date: DateTime.now(),
    ),
    FeedbackModel(
      id: '3',
      studentName: 'Budi Santoso',
      studentId: '456123789',
      facility: 'Wi-Fi Kampus',
      rating: 2,
      comments: 'Sinyal tidak stabil',
      date: DateTime.now(),
    ),
    FeedbackModel(
      id: '4',
      studentName: 'Dewi Lestari',
      studentId: '789456123',
      facility: 'Laboratorium',
      rating: 5,
      comments: 'Fasilitas lab sangat memadai',
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final facilityStats = _calculateFacilityStats();
    final overallStats = _calculateOverallStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Feedback'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Overall Statistics Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Statistik Keseluruhan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          'Total Feedback',
                          _sampleData.length.toString(),
                          Icons.feedback,
                          Colors.blue,
                        ),
                        _buildStatItem(
                          'Rata-rata Rating',
                          overallStats['averageRating']!.toStringAsFixed(1),
                          Icons.star,
                          Colors.orange,
                        ),
                        _buildStatItem(
                          'Fasilitas Dinilai',
                          overallStats['totalFacilities'].toString(),
                          Icons.place,
                          Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Rating Distribution
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Distribusi Rating',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._buildRatingBars(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Facility Performance
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kinerja per Fasilitas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...facilityStats.entries.map((entry) => 
                      _buildFacilityPerformance(entry.key, entry.value)
                    ).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<Widget> _buildRatingBars() {
    final ratingCounts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    
    for (var feedback in _sampleData) {
      ratingCounts[feedback.rating] = ratingCounts[feedback.rating]! + 1;
    }

    final total = _sampleData.length;

    return ratingCounts.entries.map((entry) {
      final percentage = total > 0 ? (entry.value / total * 100) : 0;
      
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text('${entry.key} Bintang'),
            ),
            Expanded(
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getRatingColor(entry.key),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: Text('${percentage.toStringAsFixed(1)}%'),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildFacilityPerformance(String facility, Map<String, dynamic> stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(facility),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: stats['averageRating'] / 5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getRatingColor(stats['averageRating'].round()),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              stats['averageRating'].toStringAsFixed(1),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Map<String, dynamic>> _calculateFacilityStats() {
    final Map<String, List<int>> facilityRatings = {};
    
    for (var feedback in _sampleData) {
      if (!facilityRatings.containsKey(feedback.facility)) {
        facilityRatings[feedback.facility] = [];
      }
      facilityRatings[feedback.facility]!.add(feedback.rating);
    }

    final Map<String, Map<String, dynamic>> stats = {};
    
    facilityRatings.forEach((facility, ratings) {
      final average = ratings.reduce((a, b) => a + b) / ratings.length;
      stats[facility] = {
        'averageRating': average,
        'totalFeedback': ratings.length,
      };
    });

    return stats;
  }

  Map<String, dynamic> _calculateOverallStats() {
    final totalRating = _sampleData.fold(0, (sum, feedback) => sum + feedback.rating);
    final averageRating = _sampleData.isNotEmpty ? totalRating / _sampleData.length : 0;
    
    final uniqueFacilities = _sampleData.map((f) => f.facility).toSet();

    return {
      'averageRating': averageRating,
      'totalFacilities': uniqueFacilities.length,
    };
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1: return Colors.red;
      case 2: return Colors.orange;
      case 3: return Colors.yellow[700]!;
      case 4: return Colors.lightGreen;
      case 5: return Colors.green;
      default: return Colors.grey;
    }
  }
}