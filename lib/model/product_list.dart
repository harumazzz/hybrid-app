import 'package:hybrid_app/model/product.dart';

class ProductList {
  List<Product>? products;

  ProductList({
    this.products,
  });

  ProductList.fromJson(Map<String, dynamic> json) {
    products = [...(json['products'] as List<dynamic>).map((e) => Product.fromJson(e))];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products?.toList() ?? [];
    return data;
  }
}
