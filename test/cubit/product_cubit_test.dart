import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_app/cubit/product_cubit/product_cubit.dart';
import 'package:hybrid_app/model/product.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'product_cubit_test.mocks.dart';

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
      return ProductCubit(productRepository: mockProductRepository);
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
      return ProductCubit(productRepository: mockProductRepository);
    },
    act: (bloc) async => await bloc.loadProducts(),
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
      return ProductCubit(productRepository: mockProductRepository);
    },
    act: (bloc) async => await bloc.loadProducts(),
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
            Product(id: 1, brand: 'A'),
            Product(id: 2, brand: 'B'),
            Product(id: 3, brand: 'C'),
            Product(id: 4, brand: 'D'),
            Product(id: 5, brand: 'E'),
          ],
        ),
      );
      when(mockProductRepository.getAllProducts(limit: 5, skip: 5)).thenAnswer(
        (_) async => ProductList(
          products: [
            Product(id: 6, brand: 'A'),
            Product(id: 7, brand: 'A'),
            Product(id: 8, brand: 'A'),
            Product(id: 9, brand: 'A'),
            Product(id: 10, brand: 'A'),
          ],
        ),
      );
      return ProductCubit(productRepository: mockProductRepository);
    },
    act: (bloc) async {
      await bloc.loadProducts();
      await bloc.loadProducts();
    },
    skip: 1,
    expect: () => [
      isA<ProductFinish>(),
      isA<ProductLoading>(),
      isA<ProductFinish>().having(
        (state) => state.productList.products,
        'Having 10 products',
        [
          Product(id: 1, brand: 'A'),
          Product(id: 2, brand: 'B'),
          Product(id: 3, brand: 'C'),
          Product(id: 4, brand: 'D'),
          Product(id: 5, brand: 'E'),
          Product(id: 6, brand: 'A'),
          Product(id: 7, brand: 'A'),
          Product(id: 8, brand: 'A'),
          Product(id: 9, brand: 'A'),
          Product(id: 10, brand: 'A'),
        ],
      ),
    ],
  );
}
