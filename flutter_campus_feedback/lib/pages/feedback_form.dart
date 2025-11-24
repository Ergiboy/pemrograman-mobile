import 'package:flutter/material.dart';
import '../models/feedback_model.dart';
import '../widgets/rating_widget.dart';

class FeedbackForm extends StatefulWidget {
  final String? initialFacility;
  
  const FeedbackForm({super.key, this.initialFacility});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final List<FeedbackModel> _feedbacks = [];

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  
  String _selectedFacility = 'Perpustakaan';
  int _rating = 3;

  final List<String> _facilities = [
    'Perpustakaan',
    'Laboratorium',
    'Ruang Kelas',
    'Kantin',
    'Parkiran',
    'Wi-Fi Kampus',
    'Layanan Administrasi',
    'Fasilitas Olahraga',
    'Layanan Kesehatan',
    'Lainnya'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialFacility != null) {
      _selectedFacility = widget.initialFacility!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitFeedback,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Student Information Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Mahasiswa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Mahasiswa',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Masukkan nama lengkap',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap masukkan nama';
                          }
                          if (value.length < 3) {
                            return 'Nama minimal 3 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          labelText: 'NIM',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.badge),
                          hintText: 'Masukkan NIM',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap masukkan NIM';
                          }
                          if (value.length < 5) {
                            return 'NIM minimal 5 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Facility Selection Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pilih Fasilitas/Layanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedFacility,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Fasilitas/Layanan',
                          prefixIcon: Icon(Icons.place),
                        ),
                        items: _facilities.map((String facility) {
                          return DropdownMenuItem<String>(
                            value: facility,
                            child: Text(facility),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFacility = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pilih fasilitas yang akan dinilai';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Rating Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rating Kepuasan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: RatingWidget(
                          initialRating: _rating.toDouble(),
                          onRatingChanged: (rating) {
                            setState(() {
                              _rating = rating.toInt();
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          _getRatingText(_rating),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getRatingColor(_rating),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          _getRatingDescription(_rating),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Comments Section
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Komentar & Saran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _commentsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Masukkan komentar atau saran Anda',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          hintText: 'Berikan masukan konstruktif untuk perbaikan fasilitas...',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap masukkan komentar atau saran';
                          }
                          if (value.length < 10) {
                            return 'Komentar minimal 10 karakter';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Submit Button
              ElevatedButton(
                onPressed: _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Kirim Feedback',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Reset Button
              OutlinedButton(
                onPressed: _resetForm,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Reset Form',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
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

  String _getRatingDescription(int rating) {
    switch (rating) {
      case 1: return 'Fasilitas sangat tidak memuaskan dan perlu perbaikan segera';
      case 2: return 'Fasilitas kurang memuaskan dan perlu banyak perbaikan';
      case 3: return 'Fasilitas cukup memuaskan namun masih ada yang perlu ditingkatkan';
      case 4: return 'Fasilitas memuaskan dan sudah baik';
      case 5: return 'Fasilitas sangat memuaskan dan excellent';
      default: return 'Fasilitas cukup memuaskan namun masih ada yang perlu ditingkatkan';
    }
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

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Create new feedback
      final newFeedback = FeedbackModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentName: _nameController.text,
        studentId: _idController.text,
        facility: _selectedFacility,
        rating: _rating,
        comments: _commentsController.text,
        date: DateTime.now(),
      );

      // Simpan feedback (dalam state management sederhana)
      _feedbacks.add(newFeedback);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Feedback Terkirim'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Terima kasih atas feedback Anda!'),
              const SizedBox(height: 8),
              Text('Fasilitas: $_selectedFacility'),
              Text('Rating: ${_getRatingText(_rating)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _resetForm();
              },
              child: const Text('Tambah Lagi'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous page
              },
              child: const Text('Selesai'),
            ),
          ],
        ),
      );
    } else {
      // Show error message if form is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap periksa kembali data yang dimasukkan'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _idController.clear();
    _commentsController.clear();
    setState(() {
      _selectedFacility = widget.initialFacility ?? 'Perpustakaan';
      _rating = 3;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form telah direset'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _commentsController.dispose();
    super.dispose();
  }
}