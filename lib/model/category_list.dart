import 'package:hybrid_app/model/category.dart';

class CategoryList {
  List<Category>? data;

  CategoryList({
    this.data,
  });

  CategoryList.fromJson(Map<String, dynamic> json) {
    data = [
      ...(json as List<dynamic>).map(
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
}
