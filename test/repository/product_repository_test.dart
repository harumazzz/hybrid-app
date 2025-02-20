import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:hybrid_app/api/product_api.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';

import 'product_repository_test.mocks.dart';

@GenerateMocks([ProductApi])
void main() {
  late ProductRepository productRepository;
  late MockProductApi mockProductApi;

  setUp(() {
    mockProductApi = MockProductApi();
    productRepository = ProductRepository(mockProductApi);
  });

  group('ProductRepository', () {
    test('Fetch all products', () async {
      final mockProductList = ProductList(products: []);
      when(mockProductApi.getAllProducts(skip: 0, limit: 10)).thenAnswer((_) async => mockProductList);
      final result = await productRepository.getAllProducts(skip: 0, limit: 10);
      expect(result, mockProductList);
      verify(mockProductApi.getAllProducts(skip: 0, limit: 10)).called(1);
    });

    test('Fetch 1 product only, and title need to be the same', () async {
      final mockProduct = Product(id: 1, title: 'Essence Mascara Lash Princess');
      when(mockProductApi.getSingleProduct(id: 1)).thenAnswer((_) async => mockProduct);
      final result = await productRepository.getSingleProduct(id: 1);
      expect(result, mockProduct);
      expect(mockProduct.title!, result.title!);
      verify(mockProductApi.getSingleProduct(id: 1)).called(1);
    });

    test('Should search products by title', () async {
      final mockProductList = ProductList(products: []);
      when(mockProductApi.searchProducts(prefix: 'test', skip: 0, limit: 10)).thenAnswer((_) async => mockProductList);
      final result = await productRepository.searchProducts(prefix: 'test', skip: 0, limit: 10);
      expect(result, mockProductList);
      verify(mockProductApi.searchProducts(prefix: 'test', skip: 0, limit: 10)).called(1);
    });

    test('Should return all categories', () async {
      final mockCategoryList = CategoryList(data: []);
      when(mockProductApi.getAllCategories()).thenAnswer((_) async => mockCategoryList);
      final result = await productRepository.getAllCategories();
      expect(result, mockCategoryList);
      verify(mockProductApi.getAllCategories()).called(1);
    });

    test('Should fetch products by category', () async {
      final mockProductList = ProductList(products: []);
      when(mockProductApi.getAllProductsByCategory(
        categoryName: 'beauty',
        skip: 0,
        limit: 10,
      )).thenAnswer((_) async => mockProductList);
      final result = await productRepository.getAllProductsByCategory(
        categoryName: 'beauty',
        skip: 0,
        limit: 10,
      );
      expect(result, mockProductList);
      verify(mockProductApi.getAllProductsByCategory(
        categoryName: 'beauty',
        skip: 0,
        limit: 10,
      )).called(1);
    });
  });
}
