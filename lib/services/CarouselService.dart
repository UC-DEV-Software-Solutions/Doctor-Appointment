import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_testing/services/storage.dart';
import '../models/CarouselImageModel.dart';

class CarouselService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload and replace image in FireStore
  Future<void> uploadAndReplaceImage(Uint8List file, String folderName, int slotNumber, String docName) async {
    try {
      // Upload the image using the StorageServices class
      String imageUrl = await StorageServices().uploadImage(
        folderName: folderName,
        isPrescription: false,
        file: file,
      );

      // Fetch current carousel data
      DocumentSnapshot docSnapshot = await _firestore.collection('carousel').doc(docName).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> existingData = docSnapshot.data() as Map<String, dynamic>;
        CarouselImageModel carousel = CarouselImageModel.fromMap(existingData);

        // Update the image at the specified slot
        if (slotNumber == 1) {
          carousel = CarouselImageModel(image1: imageUrl, image2: carousel.image2, image3: carousel.image3);
        } else if (slotNumber == 2) {
          carousel = CarouselImageModel(image1: carousel.image1, image2: imageUrl, image3: carousel.image3);
        } else if (slotNumber == 3) {
          carousel = CarouselImageModel(image1: carousel.image1, image2: carousel.image2, image3: imageUrl);
        }

        // Update Firestore with the new data
        await _firestore.collection('carousel').doc(docName).set(carousel.toMap());
      } else {
        // Handle the case when the document doesn't exist (e.g., create a new one)
        CarouselImageModel newCarousel = CarouselImageModel(
          image1: slotNumber == 1 ? imageUrl : '',
          image2: slotNumber == 2 ? imageUrl : '',
          image3: slotNumber == 3 ? imageUrl : '',
        );

        await _firestore.collection('carousel').doc(docName).set(newCarousel.toMap());
      }
    } catch (e) {
      print('Error uploading and replacing image: $e');
    }
  }

  // Fetch the current carousel images
  Future<CarouselImageModel?> getCarouselImages(String docName) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('carousel').doc(docName).get();

      if (snapshot.exists) {
        return CarouselImageModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
    return null;
  }
}
