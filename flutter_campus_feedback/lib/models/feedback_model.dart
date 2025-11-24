class FeedbackModel {
  final String id;
  final String studentName;
  final String studentId;
  final String facility;
  final int rating;
  final String comments;
  final DateTime date;

  FeedbackModel({
    required this.id,
    required this.studentName,
    required this.studentId,
    required this.facility,
    required this.rating,
    required this.comments,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentName': studentName,
      'studentId': studentId,
      'facility': facility,
      'rating': rating,
      'comments': comments,
      'date': date.toIso8601String(),
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      studentName: map['studentName'],
      studentId: map['studentId'],
      facility: map['facility'],
      rating: map['rating'],
      comments: map['comments'],
      date: DateTime.parse(map['date']),
    );
  }
}