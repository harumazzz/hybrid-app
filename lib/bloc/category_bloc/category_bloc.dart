import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_app/model/category_list.dart';
import 'package:hybrid_app/repository/product_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepository productRepository;

  CategoryBloc({
    required this.productRepository,
  }) : super(const CategoryInitial()) {
    on<CategoryLoadEvent>(_loadCategory);
  }

  Future<void> _loadCategory(
    CategoryLoadEvent event,
    Emitter<CategoryState> emit,
  ) async {
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
