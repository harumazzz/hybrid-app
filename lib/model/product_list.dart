import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:hybrid_app/model/product.dart';

// ignore: must_be_immutable
class ProductList extends Equatable {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ProductList && listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;

  @override
  List<Object?> get props => [products];
}
