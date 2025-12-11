import 'package:flutter/material.dart';
import 'model/feedback_item.dart';
import 'feedback_detail_page.dart';

class FeedbackListPage extends StatefulWidget {
  final List<FeedbackItem> feedbackList;
  final Function(String) onFeedbackDeleted;
  
  const FeedbackListPage({
    super.key,
    required this.feedbackList,
    required this.onFeedbackDeleted,
  });

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Feedback'),
        centerTitle: true,
        elevation: 0,
      ),
      body: widget.feedbackList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum ada feedback',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Silakan isi formulir feedback terlebih dahulu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali ke Beranda'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.feedbackList.length,
              itemBuilder: (context, index) {
                FeedbackItem feedback = widget.feedbackList[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackDetailPage(
                            feedback: feedback,
                            onDelete: () {
                              widget.onFeedbackDeleted(feedback.id);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: feedback.jenisFeedbackColor.withOpacity(0.2),
                      child: Icon(
                        feedback.jenisFeedbackIcon,
                        color: feedback.jenisFeedbackColor,
                      ),
                    ),
                    title: Text(
                      feedback.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(feedback.fakultas),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${feedback.nilaiKepuasan.toStringAsFixed(1)}/5.0',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: feedback.jenisFeedbackColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: feedback.jenisFeedbackColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                feedback.jenisFeedback,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: feedback.jenisFeedbackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
        tooltip: 'Kembali ke Beranda',
      ),
    );
  }
}