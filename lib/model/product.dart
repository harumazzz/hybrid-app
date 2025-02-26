import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:hybrid_app/model/dimension.dart';
import 'package:hybrid_app/model/meta.dart';
import 'package:hybrid_app/model/review.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  Dimension? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Review>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;

  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = (json['price'] as num).toDouble();
    discountPercentage = (json['discountPercentage'] as num).toDouble();
    rating = (json['rating'] as num).toDouble();
    stock = json['stock'];
    tags = json['tags'].cast<String>();
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null ? Dimension.fromJson(json['dimensions']) : null;
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;
    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }
    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    return data;
  }

  double get discountedPrice => price! * (1 - discountPercentage! / 100);

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    int? weight,
    Dimension? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Review>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      reviews: reviews ?? this.reviews,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      meta: meta ?? this.meta,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      category,
      price,
      discountPercentage,
      rating,
      stock,
      tags,
      brand,
      sku,
      weight,
      dimensions,
      warrantyInformation,
      shippingInformation,
      availabilityStatus,
      reviews,
      returnPolicy,
      minimumOrderQuantity,
      meta,
      images,
      thumbnail,
    ];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.discountPercentage == discountPercentage &&
        other.rating == rating &&
        other.stock == stock &&
        listEquals(other.tags, tags) &&
        other.brand == brand &&
        other.sku == sku &&
        other.weight == weight &&
        other.dimensions == dimensions &&
        other.warrantyInformation == warrantyInformation &&
        other.shippingInformation == shippingInformation &&
        other.availabilityStatus == availabilityStatus &&
        listEquals(other.reviews, reviews) &&
        other.returnPolicy == returnPolicy &&
        other.minimumOrderQuantity == minimumOrderQuantity &&
        other.meta == meta &&
        listEquals(other.images, images) &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        discountPercentage.hashCode ^
        rating.hashCode ^
        stock.hashCode ^
        tags.hashCode ^
        brand.hashCode ^
        sku.hashCode ^
        weight.hashCode ^
        dimensions.hashCode ^
        warrantyInformation.hashCode ^
        shippingInformation.hashCode ^
        availabilityStatus.hashCode ^
        reviews.hashCode ^
        returnPolicy.hashCode ^
        minimumOrderQuantity.hashCode ^
        meta.hashCode ^
        images.hashCode ^
        thumbnail.hashCode;
  }
}
