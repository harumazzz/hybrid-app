import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hybrid_app/cubit/category_cubit/category_cubit.dart';
import 'package:hybrid_app/model/category.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'category_cubit_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
  });

  blocTest(
    'Should load category list',
    build: () {
      when(mockProductRepository.getAllCategories()).thenAnswer(
        (_) async => CategoryList(data: [Category(name: 'test', slug: 'test', url: 'https://test.com')]),
      );
      return CategoryCubit(productRepository: mockProductRepository);
    },
    act: (cubit) async => await cubit.loadCategory(),
    expect: () => [isA<CategoryLoad>(), isA<CategoryLoaded>()],
  );

  blocTest(
    'Should be error when load category list',
    build: () {
      when(mockProductRepository.getAllCategories()).thenThrow(Exception('NOT FOUND'));
      return CategoryCubit(productRepository: mockProductRepository);
    },
    act: (cubit) async => await cubit.loadCategory(),
    expect: () => [
      isA<CategoryLoad>(),
      isA<CategoryLoadError>().having((state) => state.message, 'error message', 'Exception: NOT FOUND')
    ],
  );
}
