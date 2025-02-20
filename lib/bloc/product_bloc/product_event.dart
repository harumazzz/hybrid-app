part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class ProductLoadEvent extends ProductEvent {
  const ProductLoadEvent();
}

final class ProductClearEvent extends ProductEvent {
  const ProductClearEvent();
}

final class ProductSearchEvent extends ProductEvent {
  const ProductSearchEvent({
    required this.prefix,
  });

  final String prefix;

  @override
  List<Object?> get props => [prefix];
}

final class ProductFilterEvent extends ProductEvent {
  const ProductFilterEvent({
    required this.category,
  });

  final String category;

  @override
  List<Object?> get props => [category];
}
