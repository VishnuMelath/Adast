
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int rating;
  final double itemSize;
  final Color filledColor;
  final Color borderColor;

  const RatingBar({
    super.key,
    required this.rating,
    this.itemSize = 32,
    this.filledColor = Colors.amber,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? filledColor : borderColor,
          size: itemSize,
        ),
      ),
    );
  }
}
