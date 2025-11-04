import 'package:flutter/material.dart';
import 'feedback_results.dart'; // IMPORT YANG DITAMBAHKAN

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({Key? key}) : super(key: key);

  @override
  _FeedbackFormPageState createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;
  List<Map<String, dynamic>> _feedbacks = [];

  void _submitFeedback() {
    if (_formKey.currentState!.validate() && _selectedRating > 0) {
      final newFeedback = {
        'name': _nameController.text,
        'comment': _commentController.text,
        'rating': _selectedRating,
        'date': DateTime.now(),
      };

      setState(() {
        _feedbacks.add(newFeedback);
      });

      // Navigate to results page with updated feedback list
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackResultsPage(
            feedbacks: _feedbacks,
            onFeedbackUpdated: (updatedFeedbacks) {
              setState(() {
                _feedbacks = updatedFeedbacks;
              });
            },
          ),
        ),
      );

      // Clear form
      _nameController.clear();
      _commentController.clear();
      setState(() {
        _selectedRating = 0;
      });
    } else {
      // Show error if rating not selected
      if (_selectedRating == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan pilih rating terlebih dahulu'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
          child: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 40,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Form'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (_feedbacks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackResultsPage(
                      feedbacks: _feedbacks,
                      onFeedbackUpdated: (updatedFeedbacks) {
                        setState(() {
                          _feedbacks = updatedFeedbacks;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan nama';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Comment Field
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Komentar',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Silakan masukkan komentar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Rating Section
              const Text(
                'Rating:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRatingStars(),
              const SizedBox(height: 10),
              Text(
                _selectedRating > 0
                    ? 'Rating: $_selectedRating/5'
                    : 'Pilih rating (1-5)',
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedRating > 0 ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              // View Results Button
              if (_feedbacks.isNotEmpty) ...[
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackResultsPage(
                          feedbacks: _feedbacks,
                          onFeedbackUpdated: (updatedFeedbacks) {
                            setState(() {
                              _feedbacks = updatedFeedbacks;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text('Lihat Hasil Feedback'),
                ),
              ],

              // Feedback counter
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Total Feedback: ${_feedbacks.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}
