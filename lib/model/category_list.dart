import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:hybrid_app/model/category.dart';

// ignore: must_be_immutable
class CategoryList extends Equatable {
  List<Category>? data;

  CategoryList({
    this.data,
  });

  CategoryList.fromJson(List<dynamic> json) {
    data = [
      ...json.map(
        (e) => Category.fromJson(e),
      ),
    ];
  }

  List<Map<String, dynamic>> toJson() {
    return <Map<String, dynamic>>[
      ...data?.map((e) => e.toJson()) ?? [],
    ];
  }

  CategoryList copyWith({
    List<Category>? data,
  }) {
    return CategoryList(
      data: data ?? this.data,
    );
  }

  Category operator [](int index) {
    assert(data != null);
    return data![index];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is CategoryList && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;

  @override
  List<Object?> get props => [data];
}
