class ServiceModel {
  final String uid;
  final String title;
  final String imageUrl;
  final num price;
  num total = 0;

  ServiceModel({
    required this.uid,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}