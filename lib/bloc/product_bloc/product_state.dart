part of 'product_bloc.dart';

@immutable
class ProductState extends Equatable {
  final int page;
  final int limit;
  final ProductList productList;

  const ProductState({
    required this.limit,
    required this.page,
    required this.productList,
  });

  @override
  List<Object> get props => [page, limit, productList];

  ProductState copyWith({
    int? page,
    int? limit,
    ProductList? productList,
  }) {
    return ProductState(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      productList: productList ?? this.productList,
    );
  }

  int get skip => limit * page;
}

final class ProductInitial extends ProductState {
  const ProductInitial({
    required super.limit,
    required super.page,
    required super.productList,
  });
}

final class ProductFirstLoading extends ProductState {
  const ProductFirstLoading({
    required super.limit,
    required super.page,
    required super.productList,
  });
}

final class ProductLoading extends ProductState {
  const ProductLoading({
    required super.limit,
    required super.page,
    required super.productList,
  });
}

final class ProductFinish extends ProductState {
  const ProductFinish({
    required super.limit,
    required super.page,
    required super.productList,
  });
}

final class ProductError extends ProductState {
  final String message;

  const ProductError({
    required super.limit,
    required super.page,
    required super.productList,
    required this.message,
  });

  @override
  List<Object> get props => [...super.props, message];

  @override
  ProductError copyWith({
    int? page,
    int? limit,
    ProductList? productList,
    String? message,
  }) {
    return ProductError(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      productList: productList ?? this.productList,
      message: message ?? this.message,
    );
  }
}

final class ProductFull extends ProductState {
  const ProductFull({
    required super.limit,
    required super.page,
    required super.productList,
  });
}
