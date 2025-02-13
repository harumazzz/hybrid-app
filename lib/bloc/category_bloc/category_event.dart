part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryLoadEvent extends CategoryEvent {
  const CategoryLoadEvent();
}
