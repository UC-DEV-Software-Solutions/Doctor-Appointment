import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_testing/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/CarouselImageModel.dart';
import '../../services/CarouselService.dart';
import '../../widgets/ImagePickerWithSave.dart';

class EditCarouselScreen extends StatefulWidget {
  const EditCarouselScreen({super.key});

  @override
  State<EditCarouselScreen> createState() => _EditCarouselScreenState();
}

class _EditCarouselScreenState extends State<EditCarouselScreen> {
  Uint8List? _image1;
  Uint8List? _image2;
  Uint8List? _image3;

  final ImagePicker _picker = ImagePicker();

  CarouselImageModel? _carouselImages;

  Future<void> _loadCarouselImages() async {
    CarouselImageModel? images = await CarouselService().getCarouselImages('carouselImages');
    setState(() {
      _carouselImages = images;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCarouselImages();
  }

  Future<void> _pickImage(int slot) async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List fileBytes = await image.readAsBytes();
      setState(() {
        if (slot == 1) _image1 = fileBytes;
        if (slot == 2) _image2 = fileBytes;
        if (slot == 3) _image3 = fileBytes;
      });
    }
  }

  // Save the image for a specific slot
  Future<void> _saveImage(int slot, Uint8List? image) async {
    if (image != null) {
      try {
        await CarouselService().uploadAndReplaceImage(image, "carousel", slot,'carouselImages');
        // Reload the images from Firestore after saving
        await _loadCarouselImages();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image for slot $slot saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image for slot $slot: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: AppBar(
        title: const Text('Edit Carousel Images'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display carousel images
            _carouselImages != null
                ? CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: [
                _carouselImages!.image1,
                _carouselImages!.image2,
                _carouselImages!.image3
              ].map((imageUrl) {
                return Image.network(imageUrl, fit: BoxFit.cover);
              }).toList(),
            )
                : const CircularProgressIndicator(),
        
            // Image Pickers with Save Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ImagePickerWithSave(
                    slot: 1,
                    image: _image1,
                    onPickImage: () => _pickImage(1),
                    onSaveImage: () => _saveImage(1, _image1),
                  ),
                  const SizedBox(height: 10,),
                  ImagePickerWithSave(
                    slot: 2,
                    image: _image2,
                    onPickImage: () => _pickImage(2),
                    onSaveImage: () => _saveImage(2, _image2),
                  ),
                  const SizedBox(height: 10,),
                  ImagePickerWithSave(
                    slot: 3,
                    image: _image3,
                    onPickImage: () => _pickImage(3),
                    onSaveImage: () => _saveImage(3, _image3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
