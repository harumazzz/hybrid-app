import 'package:flutter/material.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/widget/image/cache_image.dart';
import 'package:hybrid_app/widget/parallax/parallax_image.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ParallaxImage(
      name: product.title!,
      price: product.discountedPrice,
      discountPercentage: product.discountPercentage!,
      image: Hero(
        tag: product,
        child: CacheImage(
          link: product.images![0],
        ),
      ),
      onTap: onTap,
    );
  }
}
