import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/CarouselImageModel.dart';
import '../services/CarouselService.dart';

class Carosel extends StatelessWidget {

  final String documentId;

  const Carosel(this.documentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CarouselImageModel?>(
      future: CarouselService().getCarouselImages(documentId), // Fetch the images from Firestore according to documentID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Show a loading spinner while fetching
        }

        if (snapshot.hasData) {
          CarouselImageModel? images = snapshot.data;

          if (images != null && images.image1.isNotEmpty) {
            List<String> imageList = [images.image1, images.image2, images.image3];

            return CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: imageList.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 400,
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('No images available')); // Handle case when no images are available
          }
        } else {
          return const Center(child: Text('Error loading images')); // Handle error case
        }
      },
    );
  }
}
