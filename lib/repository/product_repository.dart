import 'package:hybrid_app/api/product_api.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/model/product_list.dart';

class ProductRepository {
  final ProductApi _productApi;

  const ProductRepository(this._productApi);

  Future<ProductList> getAllProducts({
    required int skip,
    required int limit,
  }) async {
    return await _productApi.getAllProducts(
      skip: skip,
      limit: limit,
    );
  }

  Future<Product> getSingleProduct({
    required int id,
  }) async {
    return await _productApi.getSingleProduct(
      id: id,
    );
  }

  Future<ProductList> searchProducts({
    required String prefix,
    required int skip,
    required int limit,
  }) async {
    return await _productApi.searchProducts(
      prefix: prefix,
      skip: skip,
      limit: limit,
    );
  }

  Future<CategoryList> getAllCategories() async {
    return await _productApi.getAllCategories();
  }

  Future<ProductList> getAllProductsByCategory({
    required String categoryName,
    required int skip,
    required int limit,
  }) async {
    return await _productApi.getAllProductsByCategory(
      categoryName: categoryName,
      skip: skip,
      limit: limit,
    );
  }
}
