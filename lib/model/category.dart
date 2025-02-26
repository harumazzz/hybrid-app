import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  // Maybe should have id too ?
  String? slug;
  String? name;
  String? url;

  Category({this.slug, this.name, this.url});

  Category.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  Category copyWith({
    String? slug,
    String? name,
    String? url,
  }) {
    return Category(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    assert(name != null);
    return name!;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && other.slug == slug && other.name == name && other.url == url;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ url.hashCode;

  @override
  List<Object?> get props => [slug, name, url];
}
