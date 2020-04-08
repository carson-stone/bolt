import 'package:bolt/addingBolt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  Color backgroundColor;
  String id, username;
  Function getData;

  Camera(this.id, this.username, this.getData, {this.backgroundColor});

  @override
  _CameraState createState() =>
      _CameraState(id, username, getData, backgroundColor);
}

class _CameraState extends State<Camera> {
  var picture;
  String id, username;
  Color backgroundColor;
  Function getData;
  bool useCamera;

  _CameraState(this.id, this.username, this.getData, this.backgroundColor);

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
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            'Select image source',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'camera',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () {
                setState(() {
                  useCamera = true;
                });
                selectImageFromSource();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'gallery',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
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
      backgroundColor: backgroundColor,
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
