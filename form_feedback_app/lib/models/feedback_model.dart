class FeedbackModel {
  String name;
  String comment;
  int rating;
  DateTime date;

  FeedbackModel({
    required this.name,
    required this.comment,
    required this.rating,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'comment': comment,
      'rating': rating,
      'date': date.toIso8601String(),
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      name: map['name'],
      comment: map['comment'],
      rating: map['rating'],
      date: DateTime.parse(map['date']),
    );
  }
}
