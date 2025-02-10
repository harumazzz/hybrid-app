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
    width = json['width'];
    height = json['height'];
    depth = json['depth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['depth'] = depth;
    return data;
  }
}
