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
  }

  Future<void> _loadProduct(
    ProductLoadEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state.productList.products!.isEmpty) {
      emit(ProductFirstLoading(limit: state.limit, page: state.page, productList: state.productList));
    } else {
      emit(ProductLoading(limit: state.limit, page: state.page, productList: state.productList));
    }
    final productRepository = ServiceLocator.get<ProductRepository>();
    try {
      final newProducts = await productRepository.getAllProducts(
        limit: state.limit,
        skip: state.skip,
      );
      state.productList.products!.addAll(newProducts.products!);
      emit(ProductFinish(
        limit: state.limit,
        page: state.page + 1,
        productList: state.productList,
      ));
    } catch (e, s) {
      // visible to debug only : stack for knowing error
      debugPrint(s.toString());
      emit(ProductError(
        limit: state.limit,
        page: state.page,
        productList: state.productList,
        message: e.toString(),
      ));
    }
  }
}
