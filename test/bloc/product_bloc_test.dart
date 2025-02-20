import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_app/bloc/product_bloc/product_bloc.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
  });

  blocTest(
    'Should be able to get one product',
    build: () {
      when(mockProductRepository.getSingleProduct(id: 1)).thenAnswer((_) async => Product(id: 1));
      return ProductBloc(productRepository: mockProductRepository);
    },
    expect: () => [],
  );

  blocTest(
    'Should be able to get 5 product',
    build: () {
      when(mockProductRepository.getAllProducts(limit: 5, skip: 0)).thenAnswer((_) async => ProductList(
            products: [
              Product(id: 1),
              Product(id: 2),
              Product(id: 3),
              Product(id: 4),
              Product(id: 5),
            ],
          ));
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) => bloc.add(ProductLoadEvent()),
    expect: () => [
      isA<ProductFirstLoading>(),
      isA<ProductFinish>().having(
        (state) => state.productList.products!.length,
        'Should have 5 product',
        5,
      ),
    ],
  );

  blocTest(
    'Should throw an exception',
    build: () {
      when(mockProductRepository.getAllProducts(limit: 5, skip: 0)).thenThrow(Exception('Bad internet'));
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) => bloc.add(ProductLoadEvent()),
    expect: () => [
      isA<ProductFirstLoading>(),
      isA<ProductError>().having(
        (state) => state.message,
        'Should have error message',
        'Exception: Bad internet',
      ),
    ],
  );

  blocTest(
    'Should continue loading',
    build: () {
      when(mockProductRepository.getAllProducts(limit: 5, skip: 0)).thenAnswer(
        (_) async => ProductList(
          products: [
            Product(id: 1),
            Product(id: 2),
            Product(id: 3),
            Product(id: 4),
            Product(id: 5),
          ],
        ),
      );
      when(mockProductRepository.getAllProducts(limit: 5, skip: 5)).thenAnswer(
        (_) async => ProductList(
          products: [
            Product(id: 6),
            Product(id: 7),
            Product(id: 8),
            Product(id: 9),
            Product(id: 10),
          ],
        ),
      );
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) async {
      bloc.add(ProductLoadEvent());
      bloc.add(ProductLoadEvent());
    },
    skip: 1,
    expect: () => [
      isA<ProductFinish>(),
      isA<ProductLoading>(),
      isA<ProductFinish>().having(
        (state) => state.productList.size,
        'Having 10 products',
        10,
      ),
    ],
  );

  blocTest(
    'Should search product by prefix',
    build: () {
      when(mockProductRepository.searchProducts(
        limit: 5,
        skip: 0,
        prefix: 'test',
      )).thenAnswer(
        (_) async => ProductList(
          products: [
            Product(id: 1),
            Product(id: 2),
            Product(id: 3),
            Product(id: 4),
            Product(id: 5),
          ],
        ),
      );
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) {
      bloc.add(ProductSearchEvent(prefix: 'test'));
    },
    skip: 0,
    expect: () => [
      isA<ProductFirstLoading>(),
      isA<ProductFinish>(),
    ],
  );

  blocTest(
    'Should filter product by category',
    build: () {
      when(mockProductRepository.getAllProductsByCategory(limit: 5, skip: 0, categoryName: 'test')).thenAnswer(
        (_) async => ProductList(
          products: [
            Product(id: 1),
            Product(id: 2),
            Product(id: 3),
            Product(id: 4),
            Product(id: 5),
          ],
        ),
      );
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) {
      bloc.add(ProductFilterEvent(category: 'test'));
    },
    skip: 0,
    expect: () => [
      isA<ProductFirstLoading>(),
      isA<ProductFinish>(),
    ],
  );

  blocTest(
    'Should throw on exception',
    build: () {
      when(mockProductRepository.getAllProductsByCategory(limit: 5, skip: 0, categoryName: 'test'))
          .thenThrow(Exception('Bad internet connection'));
      return ProductBloc(productRepository: mockProductRepository);
    },
    act: (bloc) {
      bloc.add(ProductFilterEvent(category: 'test'));
    },
    skip: 0,
    expect: () => [
      isA<ProductFirstLoading>(),
      isA<ProductError>().having(
        (state) => state.message,
        'Should have an message',
        'Exception: Bad internet connection',
      ),
    ],
  );
}
