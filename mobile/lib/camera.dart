import 'package:bolt/addingBolt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  String id, username;
  Function getData;

  Camera(this.id, this.username, this.getData);

  @override
  _CameraState createState() => _CameraState(id, username, getData);
}

class _CameraState extends State<Camera> {
  var picture;
  String id, username;
  Function getData;
  bool useCamera;

  _CameraState(this.id, this.username, this.getData);

  void selectImageFromSource() async {
    var newPicture;
    newPicture = useCamera
        ? await ImagePicker.pickImage(
            source: ImageSource.camera,
          )
        : await ImagePicker.pickImage(
            source: ImageSource.gallery,
          );

    if (newPicture == null) {
      return;
    }

    setState(() {
      picture = newPicture;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingBolt(newPicture, id, username, getData),
      ),
    );
  }

  void selectImageSource() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select image source'),
          actions: <Widget>[
            FlatButton(
              child: Text('camera'),
              onPressed: () {
                setState(() {
                  useCamera = true;
                });
                selectImageFromSource();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('gallery'),
              onPressed: () {
                setState(() {
                  useCamera = false;
                });
                selectImageFromSource();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        selectImageSource();
      },
      child: Image.asset(
        'assets/transparent-bolt.png',
        height: 80,
      ),
    );
  }
}
