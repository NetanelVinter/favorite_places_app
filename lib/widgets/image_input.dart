import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({required this.onSelectedImage ,super.key});

  final void Function(File image) onSelectedImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  

  Future<void> pickImage() async {
    var im = ImagePicker();
    var response =
        await im.pickImage(source: ImageSource.camera, maxWidth: 800);
    if (response == null) {
      return;
    }

    setState(() {
      _imageFile = File(response.path);
    });

    widget.onSelectedImage(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _imageFile == null
        ? TextButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.camera),
            label: const Text('Add picture'))
        : GestureDetector(
            onTap: pickImage,
            child: Image.file(
              _imageFile!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: _imageFile == null
            ? Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5))
            : null,
      ),
      height: 250,
      width: double.infinity,
      child: mainContent,
    );
  }
}
