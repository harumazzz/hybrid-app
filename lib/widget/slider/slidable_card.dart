import 'package:flutter/material.dart';
import 'package:hybrid_app/widget/image/cache_image.dart';

@immutable
class SlidableCard extends StatelessWidget {
  const SlidableCard({
    super.key,
    required this.link,
  });

  final String link;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      shadowColor: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.grey.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Center(
            child: CacheImage(
              link: link,
            ),
          ),
        ),
      ),
    );
  }
}
