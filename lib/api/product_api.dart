import 'package:dio/dio.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/util/service_locator.dart';

class ProductApi {
  final String _url = '/products';

  Future<ProductList> getAllProducts({
    required int skip,
    required int limit,
  }) async {
    final dio = ServiceLocator.get<Dio>();
    final data = await dio.get(_url, queryParameters: {
      'skip': skip,
      'limit': limit,
    });
    return ProductList.fromJson(data.data);
  }

  Future<Product> getSingleProduct({
    required int id,
  }) async {
    try {
      final dio = ServiceLocator.get<Dio>();
      final data = await dio.get('$_url/$id');
      return Product.fromJson(data.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProductList> searchProducts({
    required String prefix,
    required int skip,
    required int limit,
  }) async {
    try {
      final dio = ServiceLocator.get<Dio>();
      final data = await dio.get('$_url/search', queryParameters: {
        'q': prefix,
        'skip': skip,
        'limit': limit,
      });
      return ProductList.fromJson(data.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CategoryList> getAllCategories() async {
    try {
      final dio = ServiceLocator.get<Dio>();
      final data = await dio.get('$_url/categories');
      return CategoryList.fromJson(data.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProductList> getAllProductsByCategory({
    // id is faster
    required String categoryName,
  }) async {
    try {
      final dio = ServiceLocator.get<Dio>();
      final data = await dio.get('$_url/categories/$categoryName');
      return ProductList.fromJson(data.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
