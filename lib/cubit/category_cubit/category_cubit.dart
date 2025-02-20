import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductRepository productRepository;

  CategoryCubit({
    required this.productRepository,
  }) : super(const CategoryInitial());

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
