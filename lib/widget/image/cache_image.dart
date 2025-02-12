import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.link,
  });

  final String link;

  Widget _loading(DownloadProgress progress) {
    return Center(
      child: CircularProgressIndicator(
        value: progress.progress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      progressIndicatorBuilder: (context, url, progress) => _loading(progress),
    );
  }
}
