import 'package:bolt/addingBolt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  String id, username;

  Camera(this.id, this.username);

  @override
  _CameraState createState() => _CameraState(id, username);
}

class _CameraState extends State<Camera> {
  var picture;
  String id, username;

  _CameraState(this.id, this.username);

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingBolt(newPicture, id, username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        getPictures();
      },
      child: Image.asset(
        'assets/transparent-bolt.png',
        height: 80,
      ),
    );
  }
}
