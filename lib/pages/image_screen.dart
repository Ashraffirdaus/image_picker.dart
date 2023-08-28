import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  //create variable for image
  File? _image;
  // Function to capture an image from the camera
  Future getImage(ImageSource source) async {
    // Use ImagePicker to open the camera and capture an image
    final image = await ImagePicker().pickImage(source: source);

    // Check if the user canceled the image picker
    if (image == null) {
      return;
    }
    // Create a File object from the picked image's path
    final imageTemporary = File(image.path);

    // Update the state to show the selected image
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pick an Image"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "https://th-thumbnailer.cdn-si-edu.com/A7XKQrdCne940tuISIiUsgd1Ru4=/fit-in/1600x0/https://tf-cmsv2-smithsonianmag-media.s3.amazonaws.com/filer/a9/ff/a9ff31d0-aecd-464e-80c7-873e4651cd2b/mufasa.jpeg",
                    ),
            ),
            CustomButton(
              title: "Pick From Gallery",
              icon: (Icons.image_outlined),
              onClick: ()=>getImage(ImageSource.gallery),
            ),
            CustomButton(
              title: "Pick From Camera",
              icon: (Icons.camera_alt_outlined),
              onClick: ()=>getImage(ImageSource.camera),
            ),
          ],
        ));
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  void Function()? onClick,
}) {
  return Container(
    width: 200,
    child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(title)
          ],
        )),
  );
}
