import 'package:flutter/material.dart';
import 'package:hybrid_app/model/review.dart';
import 'package:material_symbols_icons/symbols.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.reviews,
  });

  final List<Review>? reviews;

  Widget _buildCommand({
    required Review review,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              review.comment!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewComment({
    required Review review,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Symbols.star,
            color: Colors.orangeAccent,
            size: 20,
          ),
          const SizedBox(width: 10.0),
          _buildCommand(review: review),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reviews == null || reviews!.isEmpty) {
      return const Text('No reviews available at the moment.', style: TextStyle(fontSize: 16));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            ...reviews!.map(
              (e) => _buildReviewComment(review: e),
            ),
          ],
        ),
      ],
    );
  }
}
