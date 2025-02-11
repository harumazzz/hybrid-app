part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final int page;
  final int limit;
  final int skip;

  const ProductState({
    required this.limit,
    required this.page,
    required this.skip,
  });

  @override
  List<Object> get props => [page, limit, skip];

  ProductState copyWith({
    int? page,
    int? limit,
    int? skip,
  }) {
    return ProductState(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      skip: skip ?? this.skip,
    );
  }
}

final class ProductInitial extends ProductState {
  const ProductInitial({
    required super.limit,
    required super.page,
    required super.skip,
  });
}

final class Producting extends ProductState {
  const Producting({
    required super.limit,
    required super.page,
    required super.skip,
  });
}

final class ProductFinish extends ProductState {
  final ProductList productList;

  const ProductFinish({
    required super.limit,
    required super.page,
    required super.skip,
    required this.productList,
  });

  @override
  List<Object> get props => [...super.props, productList];

  @override
  ProductFinish copyWith({
    int? page,
    int? limit,
    int? skip,
    ProductList? productList,
  }) {
    return ProductFinish(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      skip: skip ?? this.skip,
      productList: productList ?? this.productList,
    );
  }
}

final class ProductError extends ProductState {
  final String message;

  const ProductError({
    required super.limit,
    required super.page,
    required super.skip,
    required this.message,
  });

  @override
  List<Object> get props => [...super.props, message];

  @override
  ProductError copyWith({
    int? page,
    int? limit,
    int? skip,
    String? message,
  }) {
    return ProductError(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      skip: skip ?? this.skip,
      message: message ?? this.message,
    );
  }
}
