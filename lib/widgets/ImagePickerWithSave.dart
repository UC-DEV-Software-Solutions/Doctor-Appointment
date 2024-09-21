import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImagePickerWithSave extends StatelessWidget {
  final int slot;
  final Uint8List? image;
  final VoidCallback onPickImage; // Changed to VoidCallback for better readability
  final VoidCallback onSaveImage; // Changed to VoidCallback for better readability

  const ImagePickerWithSave({
    super.key,
    required this.slot,
    required this.image,
    required this.onPickImage,
    required this.onSaveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            width: 170,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.blueGrey,
            ),
            child: image != null
                ? Image.memory(image!, fit: BoxFit.cover) // Use ! to assert non-null
                : Icon(Icons.add_a_photo),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onSaveImage,
          child: Text('Save Slot $slot'),
        ),
      ],
    );
  }
}
