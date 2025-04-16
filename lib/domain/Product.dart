class Product {
  final String name;
  final double price;
  final String image;
  final double rating;
  final int reviews;
  bool isWishlisted;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.reviews,
    this.isWishlisted = false,
  });
}