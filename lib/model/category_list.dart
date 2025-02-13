import 'package:hybrid_app/model/category.dart';

class CategoryList {
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
}
