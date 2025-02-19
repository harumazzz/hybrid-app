import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:hybrid_app/util/service_locator.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository = ServiceLocator.get<ProductRepository>();

  ProductCubit() : super(ProductInitial(page: 0, limit: 5, productList: ProductList(products: [])));

  Future<void> loadProducts() async {
    await _fetchProducts(() => _productRepository.getAllProducts(
          limit: state.limit,
          skip: state.skip,
        ));
  }

  Future<void> searchProducts(String prefix) async {
    await _fetchProducts(() => _productRepository.searchProducts(
          prefix: prefix,
          limit: state.limit,
          skip: state.skip,
        ));
  }

  Future<void> filterProducts(String category) async {
    await _fetchProducts(() => _productRepository.getAllProductsByCategory(
          categoryName: category,
          limit: state.limit,
          skip: state.skip,
        ));
  }

  void clearProducts() {
    emit(ProductClear(limit: state.limit, page: 0, productList: ProductList(products: [])));
  }

  Future<void> _fetchProducts(Future<ProductList> Function() makeProducts) async {
    if (state.productList.products!.isEmpty) {
      emit(ProductFirstLoading(limit: state.limit, page: state.page, productList: state.productList));
    } else {
      emit(ProductLoading(limit: state.limit, page: state.page, productList: state.productList));
    }

    try {
      final newProducts = await makeProducts();
      state.productList.products!.addAll(newProducts.products!);
      emit(ProductFinish(
        limit: state.limit,
        page: state.page + 1,
        productList: state.productList,
      ));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(ProductError(
        limit: state.limit,
        page: state.page,
        productList: state.productList,
        message: e.toString(),
      ));
    }
  }
}
