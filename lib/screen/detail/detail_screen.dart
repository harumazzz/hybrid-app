import 'package:flutter/material.dart';
import 'package:hybrid_app/extension/localization.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/screen/detail/review_section.dart';
import 'package:hybrid_app/widget/image/cache_image.dart';
import 'package:hybrid_app/widget/slider/image_slider.dart';
import 'package:hybrid_app/widget/slider/slidable_card.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  Widget _buildSlidableImages() {
    final length = product.images!.length;
    assert(length != 0); // not a usable product
    var child = null as Widget?; // for reusable sized box
    if (length == 1) {
      child = Padding(
        padding: const EdgeInsets.all(8.0),
        child: SlidableCard(
          link: product.images![0],
        ),
      );
    } else {
      child = ImageSlider(
        count: length,
        builder: (_, index, x, y) => SlidableCard(
          link: product.images![index],
        ),
      );
    }
    return SizedBox(
      height: 300.0,
      child: Hero(
        tag: product,
        child: child,
      ),
    );
  }

  Widget _buildPricing() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$${product.discountedPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '\$${product.price!.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.lineThrough,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStock(
    BuildContext context,
  ) {
    exchangeColor() => product.stock! > 0 ? Colors.green : Colors.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${context.localization.stock}: ${product.stock}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          '${context.localization.availibility}: ${product.availabilityStatus}',
          style: TextStyle(
            fontSize: 16,
            color: exchangeColor(),
          ),
        )
      ],
    );
  }

  Widget _buildInformation(
    BuildContext context,
  ) {
    text(String key, String value) => Text(
          '$key: $value',
          style: const TextStyle(fontSize: 16),
        );
    final los = context.localization;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${los.product_information}:',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        text(los.brand, product.brand!),
        text(los.sku, product.sku!),
        text(los.weight, '${product.weight!}g'),
        text(
          los.dimension,
          '${product.dimensions!.width} x ${product.dimensions!.height} x ${product.dimensions!.depth}',
        ),
        text(los.warranty, product.warrantyInformation!),
        text(los.warranty, product.returnPolicy!),
        text(los.shipping, product.shippingInformation!),
      ],
    );
  }

  Widget _buildProductDetails(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key: const Key('title'),
            product.title!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            key: const Key('category'),
            product.category!.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          _buildPricing(),
          const SizedBox(height: 10),
          _buildStock(context),
          const SizedBox(height: 10),
          Text(product.description!, style: const TextStyle(fontSize: 16)),
          const Divider(),
          _buildInformation(context),
          _buildMetaData(context),
          const Divider(),
          ReviewSection(
            reviews: product.reviews,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaData(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(
          "${context.localization.product_code}:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Center(
                  child: CacheImage(link: product.meta!.qrCode!),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                '${context.localization.barcode}: ${product.meta!.barcode}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildSlidableImages(),
            _buildProductDetails(context),
          ],
        ),
      ),
    );
  }
}
