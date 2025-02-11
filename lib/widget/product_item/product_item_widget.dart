import 'package:flutter/material.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onMove,
  });

  final Product product;

  final void Function(BuildContext context) onMove;

  Widget _loading(DownloadProgress progress) {
    return Center(
      child: CircularProgressIndicator(
        value: progress.progress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onMove(context),
        leading: SizedBox(
          width: 50.0,
          height: 50.0,
          child: CachedNetworkImage(
            imageUrl: product.images![0],
            progressIndicatorBuilder: (context, url, progress) => _loading(progress),
          ),
        ),
        title: Text(product.title!),
        subtitle: Text(product.description!),
      ),
    );
  }
}
