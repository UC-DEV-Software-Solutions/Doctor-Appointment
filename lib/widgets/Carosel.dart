import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carosel extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/19693.jpg',
    'assets/images/22917.jpg',
    'assets/images/48840.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imageList.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 400,
            );
          },
        );
      }).toList(),
    );
  }
}
