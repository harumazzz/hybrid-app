part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

final class CategoryLoad extends CategoryState {
  const CategoryLoad();
}

final class CategoryLoadError extends CategoryState {
  final String message;

  const CategoryLoadError({required this.message});

  @override
  List<Object> get props => [message];
}

final class CategoryLoaded extends CategoryState {
  final CategoryList value;

  const CategoryLoaded({required this.value});

  @override
  List<Object> get props => [value];
}
