import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  var picture;

  void getPictures() async {
    var newPicture;
    newPicture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (newPicture == null) {
      newPicture = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
    }

    setState(() {
      picture = newPicture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        getPictures();
      },
      child: Icon(
        Icons.flash_on,
        size: 35,
      ),
    );
  }
}
