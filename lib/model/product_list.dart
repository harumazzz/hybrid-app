import 'package:hybrid_app/model/product.dart';

class ProductList {
  List<Product>? products;

  ProductList({
    this.products,
  });

  int get size {
    assert(products != null);
    return products!.length;
  }

  ProductList.fromJson(Map<String, dynamic> json) {
    products = [...(json['products'] as List<dynamic>).map((e) => Product.fromJson(e))];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products?.toList() ?? [];
    return data;
  }

  ProductList copyWith({
    List<Product>? products,
  }) {
    return ProductList(
      products: products ?? this.products,
    );
  }

  Product operator [](int index) {
    assert(products != null);
    return products![index];
  }
}
