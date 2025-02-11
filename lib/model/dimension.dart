class Dimension {
  double? width;
  double? height;
  double? depth;

  Dimension({
    this.width,
    this.height,
    this.depth,
  });

  Dimension.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num).toDouble();
    height = (json['height'] as num).toDouble();
    depth = (json['depth'] as num).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = (width);
    data['height'] = height;
    data['depth'] = depth;
    return data;
  }

  Dimension copyWith({
    double? width,
    double? height,
    double? depth,
  }) {
    return Dimension(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }
}
