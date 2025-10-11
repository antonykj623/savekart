class SliderShareImage {
  final String image;
  final String description;

  SliderShareImage({required this.image, required this.description});

  factory SliderShareImage.fromJson(Map<String, dynamic> json) {
    return SliderShareImage(
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}