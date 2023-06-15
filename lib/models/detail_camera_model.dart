class DetailCameraModel {
  final String? cameraId;
  final String title;
  final String subTitle;
  final String description;
  final String picture;
  final String type;
  final int stock;
  final int price;

  const DetailCameraModel({
    required this.cameraId,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.picture,
    required this.stock,
    required this.type,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'camera_id': cameraId,
      'title': title,
      'sub_title': subTitle,
      'description': description,
      'picture': picture,
      'type': type,
      'stock': stock,
      'price': price,
    };
  }

  factory DetailCameraModel.fromMap(Map<String, dynamic> map) {
    return DetailCameraModel(
      cameraId: map['camera_id'] as String,
      title: map['title'] as String,
      subTitle: map['sub_title'] as String,
      description: map['description'] as String,
      picture: map['picture'] as String,
      stock: map['stock'] as int,
      type: map['type'] as String,
      price: map['price'] as int,
    );
  }

  DetailCameraModel copyWith({
    String? cameraId,
    String? title,
    String? subTitle,
    String? description,
    String? picture,
    String? type,
    int? stock,
    int? price,
  }) {
    return DetailCameraModel(
      cameraId: cameraId ?? this.cameraId,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      type: type ?? this.type,
      stock: stock ?? this.stock,
      price: price ?? this.price,
    );
  }
}
