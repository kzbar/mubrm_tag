import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

final picker = ImagePicker();
StorageReference _photoStorageReference =
    FirebaseStorage.instance.ref().child("users_photos");
/// function to get image from device
Future<PickedFile> kGetImage(
    {ImageSource imageSource = ImageSource.gallery}) async {
  return await picker.getImage(source: imageSource, imageQuality: 20);
}

/// default user image profile
const defImage =
    'https://firebasestorage.googleapis.com/v0/b/mubrm-tag.appspot.com/o/user.png?alt=media&token=7711a266-7292-46dc-971c-20a0abc7e978';

/// function to upload user image to storage firebase
Future kUploadImage(
    {Function success,
    Function fail,
    image,
    userId,
    Function progress,
    String name}) async {
  try {
    final String fileName = name != null ? name : Uuid().v4();
    StorageReference photoRef = _photoStorageReference.child(userId);
    final StorageUploadTask uploadTask =
        photoRef.child(fileName).putFile(image);
    uploadTask.events.listen((event) {
      progress(event.snapshot.bytesTransferred.toDouble() /
          event.snapshot.totalByteCount.toDouble());
    });
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    String picture = await downloadUrl.ref.getDownloadURL();
    Map<String, dynamic> map = {};
    map['image'] = picture;
    map['image_path'] = fileName;
    success(map);
  } catch (error) {
    fail(error);
  }
}

showAndroidDialog(context, message) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(
              'ERROR',
              style: TextStyle(color: Colors.red),
            ),
            content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  message,
                  style: kTextStyleTile,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

showIosDialog(context, message) {
  showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
            title: new Text(
              'ERROR',
              style: TextStyle(color: Colors.red),
            ),
            content: new Text(
              message,
              style: kTextStyleTile,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}
/// main app color
const colorsMap = {
  50: Color.fromRGBO(255, 171, 131, .1),
  100: Color.fromRGBO(255, 171, 131, .2),
  200: Color.fromRGBO(255, 171, 131, .3),
  300: Color.fromRGBO(255, 171, 131, .4),
  400: Color.fromRGBO(255, 171, 131, .5),
  500: Color.fromRGBO(255, 171, 131, .6),
  600: Color.fromRGBO(255, 171, 131, .7),
  700: Color.fromRGBO(255, 171, 131, .8),
  800: Color.fromRGBO(255, 171, 131, .9),
  900: Color.fromRGBO(255, 171, 131, .9),
};
const MaterialColor customColor = MaterialColor(0xFFAB8361, colorsMap);



/// function to share
Future share({ref, BuildContext context}) async {
  final RenderBox box = context.findRenderObject();
  await Share.share(ref,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

const Color color1 = Color(0xFFE3C397);
const Color color2 = Color(0xFFAB8361);

const kBoxDecoration = BoxDecoration(
    image: DecorationImage(
        image: AssetImage('images/PNG/background.png'), fit: BoxFit.fill));
const kBoxDecorationEditText = BoxDecoration(
    color: Color(0xFFE3C397),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ));

const kTextStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'LBC',
    decoration: TextDecoration.none,
    decorationStyle: TextDecorationStyle.dashed,
    decorationColor: Color(0x00ffffff));
const kTextStyleEditText = TextStyle(
    fontSize: 24.0,
    color: Colors.black,
    fontFamily: 'LBC',
    decoration: TextDecoration.none,
    decorationStyle: TextDecorationStyle.solid,
    decorationColor: Color(0x00ffffff));

const kTextStyleTile = TextStyle(
    fontSize: 50.0,
    fontFamily: 'LBC',
    fontWeight: FontWeight.bold,
    color: Color(0xFFE3C397),
    decorationColor: Color(0xFFE3C397));

/// add link Icon object
const kFooterIcon = {
  "id": 1,
  "socialName": 'footer_icon',
  "socialLinkIos": '',
  "socialLinkAndroid": '',
  "socialLinkWeb": '',
  "socialIcon": 'footer_icon',
  "socialIsSelect": false,
  "socialAddedTo": false,
  "value": null,
  "messageAR": '',
  "messageEN": ''
};

/// setup first time database {socialMediaSelectedList}
/// theme app
ThemeData themeData = ThemeData(
    primaryColor: Color(0xFFE3C397),
    primarySwatch: customColor,
    textSelectionColor: Colors.white,
    textSelectionHandleColor: Colors.white,
    fontFamily: 'LBC',
    textTheme: TextTheme());

/// Logging config
const kLOG_TAG = "[MUBRM]";
const kLOG_ENABLE = true;

printLog(String fun, dynamic data) {
  if (kLOG_ENABLE) {
    print("[${DateTime.now().toUtc()}]$kLOG_TAG${data.toString()}[$fun]");
  }
}

const String kLogo = 'images/PNG/logo.jpg';
