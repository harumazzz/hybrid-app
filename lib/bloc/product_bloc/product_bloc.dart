import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/model/product_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:hybrid_app/util/service_locator.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  //  5 product => limit = 5
  ProductBloc() : super(ProductInitial(page: 0, limit: 5, productList: ProductList(products: []))) {
    on<ProductLoadEvent>(_loadProduct);
    on<ProductSearchEvent>(_searchProduct);
    on<ProductClearEvent>(_clear);
    on<ProductFilterEvent>(_filterProducts);
  }

  Future<void> _loadProduct(
    ProductLoadEvent event,
    Emitter<ProductState> emit,
  ) async {
    return await _fetchProducts(
      event: event,
      emit: emit,
      makeProducts: (ProductRepository productRepository) async {
        return await productRepository.getAllProducts(
          limit: state.limit,
          skip: state.skip,
        );
      },
    );
  }

  Future<void> _searchProduct(
    ProductSearchEvent event,
    Emitter<ProductState> emit,
  ) async {
    return await _fetchProducts(
      event: event,
      emit: emit,
      makeProducts: (ProductRepository productRepository) async {
        return await productRepository.searchProducts(
          prefix: event.prefix,
          limit: state.limit,
          skip: state.skip,
        );
      },
    );
  }

  Future<void> _filterProducts(
    ProductFilterEvent event,
    Emitter<ProductState> emit,
  ) async {
    return await _fetchProducts(
      event: event,
      emit: emit,
      makeProducts: (ProductRepository productRepository) async {
        return await productRepository.getAllProductsByCategory(
          categoryName: event.category,
          limit: state.limit,
          skip: state.skip,
        );
      },
    );
  }

  void _clear(
    ProductClearEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductClear(limit: state.limit, page: 0, productList: ProductList(products: [])));
  }

  Future<void> _fetchProducts({
    required Future<ProductList> Function(ProductRepository productRepository) makeProducts,
    required ProductEvent event,
    required Emitter<ProductState> emit,
  }) async {
    if (state.productList.products!.isEmpty) {
      emit(ProductFirstLoading(limit: state.limit, page: state.page, productList: state.productList));
    } else {
      emit(ProductLoading(limit: state.limit, page: state.page, productList: state.productList));
    }
    final productRepository = ServiceLocator.get<ProductRepository>();
    try {
      final newProducts = await makeProducts(productRepository);
      state.productList.products!.addAll(newProducts.products!);
      emit(ProductFinish(
        limit: state.limit,
        page: state.page + 1,
        productList: state.productList,
      ));
    } catch (e, s) {
      // visible to debug only : stack for knowing error
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
