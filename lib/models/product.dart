
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.imageUrl,
      required this.description,
      required this.price,
      required this.title,
      this.isFavorite = false});
}
