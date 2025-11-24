import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;

  const RatingWidget({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentRating = (index + 1).toDouble();
                });
                widget.onRatingChanged(_currentRating);
              },
              child: Icon(
                index < _currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          '$_currentRating / 5',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}