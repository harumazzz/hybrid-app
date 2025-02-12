import 'package:flutter/material.dart';
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
      child: child,
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

  Widget _buildStock() {
    exchangeColor() => product.stock! > 0 ? Colors.green : Colors.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Stock: ${product.stock}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          'Availability: ${product.availabilityStatus}',
          style: TextStyle(
            fontSize: 16,
            color: exchangeColor(),
          ),
        )
      ],
    );
  }

  Widget _buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Product Information:',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Brand: ${product.brand}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'SKU: ${product.sku}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Weight: ${product.weight}g',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Dimensions: ${product.dimensions!.width} x ${product.dimensions!.height} x ${product.dimensions!.depth}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          'Warranty: ${product.warrantyInformation}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Return Policy: ${product.returnPolicy}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Shipping: ${product.shippingInformation}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            product.category!.toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          _buildPricing(),
          const SizedBox(height: 10),
          _buildStock(),
          const SizedBox(height: 10),
          Text(product.description!, style: const TextStyle(fontSize: 16)),
          const Divider(),
          _buildInformation(),
          _buildMetaData(),
          const Divider(),
          ReviewSection(
            reviews: product.reviews,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text(
          "Product Code:",
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
                'Barcode: ${product.meta!.barcode}',
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
            _buildProductDetails(),
          ],
        ),
      ),
    );
  }
}
