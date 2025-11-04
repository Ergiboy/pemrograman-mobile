import 'package:flutter/material.dart';

class FeedbackResultsPage extends StatefulWidget {
  final List<Map<String, dynamic>> feedbacks;
  final Function(List<Map<String, dynamic>>) onFeedbackUpdated;

  const FeedbackResultsPage({
    Key? key,
    required this.feedbacks,
    required this.onFeedbackUpdated,
  }) : super(key: key);

  @override
  _FeedbackResultsPageState createState() => _FeedbackResultsPageState();
}

class _FeedbackResultsPageState extends State<FeedbackResultsPage> {
  late List<Map<String, dynamic>> _feedbacks;

  @override
  void initState() {
    super.initState();
    _feedbacks = List.from(widget.feedbacks);
  }

  void _deleteFeedback(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Feedback'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus feedback ini?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _feedbacks.removeAt(index);
                });
                widget.onFeedbackUpdated(_feedbacks);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feedback berhasil dihapus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  double _calculateAverageRating() {
    if (_feedbacks.isEmpty) return 0.0;
    double sum = _feedbacks
        .map((feedback) => feedback['rating'] as int)
        .reduce((a, b) => a + b)
        .toDouble();
    return sum / _feedbacks.length;
  }

  Widget _buildRatingSummary() {
    final averageRating = _calculateAverageRating();
    final totalFeedbacks = _feedbacks.length;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              '📊 Ringkasan Feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Rating Rata-rata',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      totalFeedbacks.toString(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Text(
                      'Total Feedback',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: averageRating / 5,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 8),
            Text(
              '${(averageRating / 5 * 100).toStringAsFixed(1)}% Kepuasan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackList() {
    if (_feedbacks.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.feedback_outlined, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'Belum ada feedback',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kembali ke form untuk menambahkan feedback pertama',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _feedbacks.length,
        itemBuilder: (context, index) {
          final feedback = _feedbacks[index];
          final date = feedback['date'] as DateTime;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getRatingColor(feedback['rating'] as int),
                child: Text(
                  feedback['rating'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                feedback['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    feedback['comment'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // Rating stars
                      ...List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < feedback['rating']
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                      const Spacer(),
                      // Date
                      Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteFeedback(index),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow[700]!;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Feedback'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingSummary(),
            const SizedBox(height: 20),
            const Text(
              '📝 Daftar Feedback',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFeedbackList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_comment, color: Colors.white),
        tooltip: 'Tambah Feedback Baru',
      ),
    );
  }
}
