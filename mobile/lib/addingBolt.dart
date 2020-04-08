import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AddingBolt extends StatefulWidget {
  var bolt;
  String parentBoltId, userID, username, make;
  Function getData;

  AddingBolt(this.bolt, this.parentBoltId, id, this.username, this.getData,
      {@required this.make})
      : this.userID = id;

  @override
  _AddingBoltState createState() =>
      _AddingBoltState(bolt, parentBoltId, userID, username, getData, make);
}

class _AddingBoltState extends State<AddingBolt> {
  var bolt;
  String parentBoltId, userID, username, make;
  Function getData;

  _AddingBoltState(this.bolt, this.parentBoltId, this.userID, this.username,
      this.getData, this.make);

  @override
  Widget build(BuildContext context) {
    if (this.parentBoltId == null) {
      parentBoltId = '';
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 775,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: double.infinity,
            child: Hero(
              tag: 'bolt',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  bolt,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    'add this bolt?',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
                FlatButton(
                    child: Text(
                      'yes',
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: Theme.of(context).accentColor),
                    ),
                    onPressed: () async {
                      String url = 'http://localhost:6000/bolts/add';

                      final mimeTypeData =
                          lookupMimeType(bolt.path, headerBytes: [0xFF, 0xD8])
                              .split('/');
                      final imageUploadRequest =
                          http.MultipartRequest('POST', Uri.parse(url));
                      final file = await http.MultipartFile.fromPath(
                          'image', bolt.path,
                          contentType:
                              MediaType(mimeTypeData[0], mimeTypeData[1]));
                      imageUploadRequest.fields['ext'] = mimeTypeData[1];
                      imageUploadRequest.fields['user_id'] = userID;
                      imageUploadRequest.fields['username'] = username;
                      imageUploadRequest.fields['description'] = 'a bolt';
                      imageUploadRequest.fields['imageUrl'] = bolt.path;
                      imageUploadRequest.fields['parent_bolt_id'] = '';
                      imageUploadRequest.files.add(file);
                      var stream = await imageUploadRequest.send();
                      var res = await http.Response.fromStream(stream);
                      var returnedId = json.decode(res.body);

                      if (this.make == 'spark') {
                        url = 'http://localhost:6000/bolts/add/spark';

                        var res = await http.post(
                          url,
                          body: {
                            'spark_id': returnedId,
                            'bolt_id': parentBoltId
                          },
                        );
                        print(json.decode(res.body).toString());
                      }

                      getData();
                      Navigator.pop(context);
                    }),
                FlatButton(
                  child: Text(
                    'no',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
