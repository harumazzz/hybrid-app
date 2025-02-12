import 'package:flutter/material.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/widget/product_item/product_tile.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onMove,
  });

  final Product product;

  final void Function(BuildContext context) onMove;

  @override
  Widget build(BuildContext context) {
    return ProductTile(
      product: product,
      onTap: () => onMove(context),
    );
  }
}
