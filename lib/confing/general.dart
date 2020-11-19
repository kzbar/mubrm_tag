import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

final picker = ImagePicker();
StorageReference _photoStorageReference =
    FirebaseStorage.instance.ref().child("users_photos");

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
showAndroidDialog(context,message) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('ERROR',style: TextStyle(color: Colors.red),),
        content: new Text("Hey! I'm Coflutter!"),
        actions: <Widget>[
          FlatButton(
            child: Text(message,style: kTextStyleTile,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ));
}

showIosDialog(context,message) {
  showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text('ERROR',style: TextStyle(color: Colors.red),),
        content: new Text(message,style: kTextStyleTile,),
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
  "messageAR":
      '',
  "messageEN":
      ''
};

/// setup first time database {socialMediaSelectedList}
const kSocialMediaSelectedList = [
  {
    "id": 1,
    "socialName": 'Email',
    "socialLinkIos": 'mailto:',
    "socialLinkAndroid": 'mailto:',
    "socialLinkWeb": 'mailto:',
    "socialIcon": '8',
    "socialIsSelect": true,
    "socialAddedTo": true,
    "value": null,
    "messageAR":
        'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
    "messageEN":
        'input your email address. This email can be the same of different from the one used for your account sign up.'
  },
  {
    "id": 2,
    "socialName": 'Twitter',
    "socialLinkIos": 'https://twitter.com/',
    "socialLinkAndroid": 'https://twitter.com/',
    "socialLinkWeb": 'https://twitter.com/',
    "socialIcon": '2',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح تطبيق تويتر واضغط على صورة حسابك, سيضهر اسم المستخدم الخاص بحسابك بلون رمادي مع علامة',
    "messageEN":
        'Open the Twitter app and tap your profile picture in the top left corner Your twitter username will be in grey with @ sing'
  },
  {
    "id": 3,
    "socialName": 'Instagram',
    "socialLinkIos": 'http://instagram.com/_u/',
    "socialLinkAndroid": 'http://instagram.com/_u/',
    "socialLinkWeb": 'http://instagram.com/_u/',
    "socialIcon": '3',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح تطبيق الانستكرام واذهب الى ملفك الشخصي, سيضهر حسابك اعلى الشاشة',
    "messageEN":
        'Open the instagram app and go to yoour profile. Your instagram username will be at the top of your screen.'
  },
  {
    "id": 4,
    "socialName": 'WhatsApp',
    "socialLinkIos": 'https://wa.me/',
    "socialLinkAndroid": 'https://wa.me/',
    "socialLinkWeb": 'https://wa.me/',
    "socialIcon": '5',
    "socialAddedTo": false,
    "socialIsSelect": false,
    "value": null,
    "messageAR":
        'افتح الواتساب واذهب الى الاعدادات اضغط على ملفك الشخصي في الاعلى وقم بنسخ ولصق الرقم مع رمز البلد.',
    "messageEN":
        'Open WhatsApp and go to Settings Tap your profile at the top and copy/paste number. include your country code!'
  },
  {
    "id": 5,
    "socialName": 'Snapchat',
    "socialLinkIos": 'https://snapchat.com/add/',
    "socialLinkAndroid": 'https://snapchat.com/add/',
    "socialLinkWeb": 'https://snapchat.com/add/',
    "socialIcon": '4',
    "socialAddedTo": false,
    "socialIsSelect": false,
    "value": null,
    "messageAR":
        'افتح السناب شات واضغط على صورة حسابك, سيضهر الحساب تحت اسم حسابك',
    "messageEN":
        'Open Snapchat and tap your profile picture in the top left corner Your username is below your Snapchat name.'
  },
  {
    "id": 6,
    "socialName": 'Tik Tok',
    "socialLinkIos": 'https://www.tiktok.com/@',
    "socialLinkAndroid": 'https://www.tiktok.com/@',
    "socialLinkWeb": 'https://www.tiktok.com/@',
    "socialIcon": '6',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح تطبيق التيك توك ثم اضغط على "صفحتي" سيضهر اسم المستخدم تحت الصورة الشخصية.',
    "messageEN":
        'Open Tik Tok and tap your profile picture in the top left corner Your username is below your Tik Tok name.'
  },
  {
    "id": 7,
    "socialName": 'Telegram',
    "socialLinkIos": 'https://t.me/',
    "socialLinkAndroid": 'https://t.me/',
    "socialLinkWeb": 'https://t.me/',
    "socialIcon": '7',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح التلغرام اضغط على ملفك الشخصي في الاعلى سيضهر اسم المستخدم تحت الصورة الشخصية.',
    "messageEN":
        'Open Telegram and tap your profile picture in the top left corner Your username is below your Telegram name.'
  },
  {
    "id": 8,
    "socialName": 'Facebook',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '1',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'اذهب الى موقع facebook.com وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN":
        'Go to facebook.com and open your Facebook profile or page Then copy and past the url link here.'
  },
  {
    "id": 9,
    "socialName": 'Phone number',
    "socialLinkIos": 'tel:',
    "socialLinkAndroid": 'tel:',
    "socialLinkWeb": 'tel:',
    "socialIcon": '9',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'ادخل رقم هاتفك بدون الرقم صفر البدائي مع رمز البلد (مثال +964 لدولة العراق)',
    "messageEN": 'Enter your phone number with country code.'
  },
  {
    "id": 10,
    "socialName": 'YouTube',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '10',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'اذهب الى قناتك او الفبديو, انقر على النقاط الثلاث في الاعلى ثم مشاركة, قم بنسخ ولصق الرابط هنا.',
    "messageEN":
        'Go to your channel or video Tap the three dots in the top right corner and tap share Copy/past the link here'
  },
  {
    "id": 12,
    "socialName": 'Custom link',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": 'https://',
    "socialIcon": '12',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح تطبيق او موقع وقم بنسخ ولصق الرابط هنا, هذا الرابط يسمح لك بمشاركة اي شي لحظيا.',
    "messageEN":
        'open your app or website link and copy/past here. This link allows your to instantly share anything.'
  },
  {
    "id": 11,
    "socialName": 'Skype',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '11',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'اذهب الى موقع SKYP وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN": ''
  },
  {
    "id": 13,
    "socialName": 'PayPal',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '13',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'انتقل إلى paypal.me واضغط على إنشاء رابط PayPal.Me الخاص بك ، انسخ / الصق هنا!',
    "messageEN":
        'Go to paypal.me and tap Create your PayPal.Me Link Copy/paste here! '
  },
  {
    "id": 14,
    "socialName": 'Zain Cash',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '14',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR": '',
    "messageEN": ''
  },
  {
    "id": 15,
    "socialName": 'LinkedIn',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '15',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'اذهب الى موقع linkedin.com وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN":
        'Go to LinkedIn.com and open your LinkedIn profile or page Then copy and past the url link here.'
  },
  {
    "id": 16,
    "socialName": 'Viber',
    "socialLinkIos": 'viber://add?number=',
    "socialLinkAndroid": 'viber://add?number=',
    "socialLinkWeb": 'viber://add?number=',
    "socialIcon": '16',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'ادخل رقم هاتفك بدون الرقم صفر البدائي مع رمز البلد (مثال 964 لدولة العراق)',
    "messageEN":
        'Open Viber and go to Settings Tap your profile at the top and copy/paste number. include your country code!'
  },
  {
    "id": 17,
    "socialName": 'Map',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '17',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":
        'افتح خرائط Google وابحث عن موقع عملك. اضغط على زر المشاركة في الجزء العلوي الأيمن وانسخ هنا مثال (https://maps.app.goo.gl/jwmqcAkfnhY18bmaA)',
    "messageEN":
        'Open Google Maps and find your business location. Tap the share button in the top right and copy here example (https://maps.app.goo.gl/jwmqcAkfnhY18bmaA)'
  },
];
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
