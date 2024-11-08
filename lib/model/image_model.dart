class ImageModel {
  final String id;
  final String imageUrl;
  final String uploaderName;
  final DateTime createdAt;

  ImageModel({
    required this.id,
    required this.imageUrl,
    required this.uploaderName,
    required this.createdAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as String,
      imageUrl: json['urls']['regular'] as String,
      uploaderName: json['user']['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
