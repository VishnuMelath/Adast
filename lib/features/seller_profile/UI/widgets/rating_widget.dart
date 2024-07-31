import 'dart:developer';

import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int initialRating;
  final Function(int) onRatingChanged;
  final double itemSize;
  final Color filledColor;
  final Color borderColor;

  const RatingBar({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
    this.itemSize = 32,
    this.filledColor = Colors.amber,
    this.borderColor = Colors.grey,
  });

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            widget.onRatingChanged(index+1);
            setState(() => _rating = index + 1);
            log(_rating.toString());
          },
          child: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: index < _rating ? widget.filledColor : widget.borderColor,
            size: widget.itemSize,
          ),
        ),
      ),
    );
  }
}
