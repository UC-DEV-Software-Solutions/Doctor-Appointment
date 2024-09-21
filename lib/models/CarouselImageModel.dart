class CarouselImageModel {
  final String image1;
  final String image2;
  final String image3;

  CarouselImageModel({
    required this.image1,
    required this.image2,
    required this.image3,
  });

  // Convert the model to a Map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'image1': image1,
      'image2': image2,
      'image3': image3,
    };
  }

  // Convert Firestore data to a CarouselImageModel
  factory CarouselImageModel.fromMap(Map<String, dynamic> map) {
    return CarouselImageModel(
      image1: map['image1'] ?? '',
      image2: map['image2'] ?? '',
      image3: map['image3'] ?? '',
    );
  }
}
