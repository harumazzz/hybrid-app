import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';
import 'package:hybrid_app/util/service_locator.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductRepository productRepository;

  CategoryCubit()
      : productRepository = ServiceLocator.get<ProductRepository>(),
        super(const CategoryInitial());

  Future<void> loadCategory() async {
    emit(const CategoryLoad());
    try {
      final data = await productRepository.getAllCategories();
      emit(CategoryLoaded(value: data));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      emit(CategoryLoadError(message: e.toString()));
    }
  }
}
