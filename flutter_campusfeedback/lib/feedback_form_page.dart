import 'package:flutter/material.dart';
import 'model/feedback_item.dart';
import 'feedback_list_page.dart';

class FeedbackFormPage extends StatefulWidget {
  final Function(FeedbackItem) onFeedbackAdded;
  
  const FeedbackFormPage({super.key, required this.onFeedbackAdded});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _pesanController = TextEditingController();
  
  String _selectedFakultas = 'Fakultas Sains dan Teknologi';
  List<String> _selectedFasilitas = [];
  double _nilaiKepuasan = 3.0;
  String _jenisFeedback = 'Saran';
  bool _setujuSyarat = false;
  
  final List<String> _fakultasList = [
    'Fakultas Sains dan Teknologi',
    'Fakultas Ilmu Sosial dan Humaniora',
    'Fakultas Ekonomi dan Bisnis',
    'Fakultas Kedokteran',
    'Fakultas Hukum',
    'Fakultas Agama Islam',
  ];
  
  final List<String> _fasilitasList = [
    'Perpustakaan',
    'Laboratorium',
    'Ruang Kelas',
    'Wi-Fi Kampus',
    'Parkiran',
    'Kantin',
    'UKM & Organisasi',
    'Layanan Administrasi',
  ];
  
  final List<String> _jenisFeedbackList = ['Saran', 'Keluhan', 'Apresiasi'];

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _pesanController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_setujuSyarat) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Perhatian!'),
            content: const Text('Anda harus menyetujui syarat dan ketentuan terlebih dahulu.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
      
      FeedbackItem newFeedback = FeedbackItem(
        nama: _namaController.text,
        nim: _nimController.text,
        fakultas: _selectedFakultas,
        fasilitas: List.from(_selectedFasilitas),
        nilaiKepuasan: _nilaiKepuasan,
        jenisFeedback: _jenisFeedback,
        pesanTambahan: _pesanController.text,
        setujuSyarat: _setujuSyarat,
      );
      
      widget.onFeedbackAdded(newFeedback);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Feedback berhasil disimpan!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackListPage(
            feedbackList: [newFeedback],
            onFeedbackDeleted: (id) {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Feedback'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Form
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Isi data dengan benar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Nama Mahasiswa
              _buildFormSection(
                title: 'Data Pribadi',
                icon: Icons.person_outline,
                children: [
                  _buildTextField(
                    label: 'Nama Mahasiswa *',
                    controller: _namaController,
                    icon: Icons.person,
                    hint: 'Masukkan nama lengkap',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'NIM *',
                    controller: _nimController,
                    icon: Icons.numbers,
                    hint: 'Masukkan NIM',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NIM wajib diisi';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'NIM harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown(
                    label: 'Fakultas *',
                    value: _selectedFakultas,
                    items: _fakultasList,
                    onChanged: (value) {
                      setState(() {
                        _selectedFakultas = value!;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Fasilitas
              _buildFormSection(
                title: 'Fasilitas yang Dinilai',
                icon: Icons.assessment_outlined,
                children: [
                  ..._fasilitasList.map((fasilitas) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: CheckboxListTile(
                          title: Text(fasilitas),
                          value: _selectedFasilitas.contains(fasilitas),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _selectedFasilitas.add(fasilitas);
                              } else {
                                _selectedFasilitas.remove(fasilitas);
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),

              const SizedBox(height: 24),

              // Nilai Kepuasan
              _buildFormSection(
                title: 'Penilaian',
                icon: Icons.star_outline,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nilai Kepuasan',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getRatingColor(_nilaiKepuasan)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_nilaiKepuasan.toStringAsFixed(1)}/5.0',
                              style: TextStyle(
                                color: _getRatingColor(_nilaiKepuasan),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Slider(
                        value: _nilaiKepuasan,
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        label: _nilaiKepuasan.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _nilaiKepuasan = value;
                          });
                        },
                        activeColor: _getRatingColor(_nilaiKepuasan),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('1 - Buruk'),
                          Text('3 - Cukup'),
                          Text('5 - Sangat Baik'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Jenis Feedback
              _buildFormSection(
                title: 'Jenis Feedback',
                icon: Icons.category_outlined,
                children: [
                  ..._jenisFeedbackList.map((jenis) {
                    Color color = _getFeedbackColor(jenis);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: RadioListTile<String>(
                          title: Row(
                            children: [
                              Icon(
                                _getFeedbackIcon(jenis),
                                color: color,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(jenis),
                            ],
                          ),
                          value: jenis,
                          groupValue: _jenisFeedback,
                          onChanged: (value) {
                            setState(() {
                              _jenisFeedback = value!;
                            });
                          },
                          activeColor: color,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),

              const SizedBox(height: 24),

              // Pesan Tambahan
              _buildFormSection(
                title: 'Pesan Tambahan',
                icon: Icons.message_outlined,
                children: [
                  TextFormField(
                    controller: _pesanController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tulis pesan tambahan di sini...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Syarat & Ketentuan
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: SwitchListTile(
                  title: const Text(
                    'Saya setuju dengan syarat dan ketentuan',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Dengan mencentang ini, Anda menyetujui semua persyaratan',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _setujuSyarat,
                  onChanged: (value) {
                    setState(() {
                      _setujuSyarat = value;
                    });
                  },
                  secondary: Icon(
                    Icons.gavel,
                    color: _setujuSyarat ? Colors.green : Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save_alt, size: 24),
                  label: const Text(
                    'Simpan Feedback',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection({
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
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.school),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Color _getRatingColor(double nilai) {
    if (nilai >= 4.0) return Colors.green;
    if (nilai >= 3.0) return Colors.blue;
    if (nilai >= 2.0) return Colors.orange;
    return Colors.red;
  }

  Color _getFeedbackColor(String jenis) {
    switch (jenis) {
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

  IconData _getFeedbackIcon(String jenis) {
    switch (jenis) {
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
}