import 'package:bolt/addingBolt.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  String id, parentBolt_id, username, make;
  Function getData;

  Camera(this.id, this.parentBolt_id, this.username, this.getData,
      {@required this.make});

  @override
  _CameraState createState() =>
      _CameraState(id, parentBolt_id, username, getData, make);
}

class _CameraState extends State<Camera> {
  var picture;
  String id, parentBolt_id, username, make;
  Color backgroundColor;
  Function getData;
  bool useCamera;

  _CameraState(
      this.id, this.parentBolt_id, this.username, this.getData, this.make) {
    this.make == 'bolt'
        ? this.backgroundColor = Colors.white
        : this.backgroundColor = Colors.white24;
  }

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
        builder: (context) => AddingBolt(
            newPicture, parentBolt_id, id, username, getData,
            make: this.make),
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
