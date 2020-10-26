import 'package:firebase_storage/firebase_storage.dart';
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

const defImage =
    'https://firebasestorage.googleapis.com/v0/b/mubrm-tag.appspot.com/o/user.png?alt=media&token=7711a266-7292-46dc-971c-20a0abc7e978';
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
Future share({ref, BuildContext context}) async{
  final RenderBox box = context.findRenderObject();
  await Share.share(ref,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

const Color color1 = Color(0xFFE3C397);
const Color color2 = Color(0xFFAB8361);


show(context) {
  Widget dialog = Container(
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
      ),
    ),
  );
  showDialog(context: context, builder: (_) => dialog);
}

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

const kDebug = false;

const kListIcons = [
  {'icon': '1', "title": "Facebook"},
  {'icon': '2', "title": "Twitter"},
  {'icon': '3', "title": "Instagram"},
  {'icon': '4', "title": "WhatsApp"},
  {'icon': '5', "title": "Snapchat"},
  {'icon': '6', "title": "Tik Tok"},
  {'icon': '7', "title": "Telegram"},
  {'icon': '8', "title": "Email"},
  {'icon': '9', "title": "Phone number"},
  {'icon': '10', "title": "YouTube"},
  {'icon': '11', "title": "custom link"},
  {'icon': '12', "title": "Sky"},
  {'icon': '13', "title": "Asiahawala"},
  {'icon': '14', "title": "Zain Cash"},
  {'icon': '15', "title": "LinkedIn"},
  {'icon': '16', "title": "Viber"},
];

const message = 'امسك mubrm في منتصف الجزء الخلفي من هاتفك لتنشيطه ، امسك المنبثقة هناك حتى تظهر النافذة المنبثقة للنجاح';
const kFooterIcon =  {
  "id": 1,
  "socialName": 'Email',
  "socialLinkIos": '',
  "socialLinkAndroid": '',
  "socialLinkWeb": '',
  "socialIcon": 'footer_icon',
  "socialIsSelect": false,
  "socialAddedTo": true,
  "value": null,
  "messageAR":'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
  "messageEN":'input your email address. This email can be the same of different from the one used for your account sign up.'

};

const kSocialList = [
  {
    "id":1,
    "socialName": 'Email',
    "socialLinkIos": 'mailto:',
    "socialLinkAndroid": 'mailto:',
    "socialLinkWeb": 'mailto:',
    "socialIcon": '8',
    "socialIsSelect": true,
    "socialAddedTo": true,
    "value": null,
    "messageAR":'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
    "messageEN":'input your email address. This email can be the same of different from the one used for your account sign up.'

  },

  {
    "id": 2,
    "socialName": 'Twitter',
    "socialLinkIos": 'twitter:///user?screen_name=',
    "socialLinkAndroid": 'twitter:///user?screen_name=',
    "socialLinkWeb": 'twitter:///user?screen_name=',
    "socialIcon": '2',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'افتح تطبيق تويتر واضغط على صورة حسابك, سيضهر اسم المستخدم الخاص بحسابك بلون رمادي مع علامة',
    "messageEN":'Open the Twitter app and tap your profile picture in the top left corner Your twitter username will be in grey with @ sing'

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
    "messageAR":'افتح تطبيق الانستكرام واذهب الى ملفك الشخصي, سيضهر حسابك اعلى الشاشة',
    "messageEN":'Open the instagram app and go to yoour profile. Your instagram username will be at the top of your screen.'


  },
  {
    "id":4,
    "socialName": 'WhatsApp',
    "socialLinkIos": 'https://wa.me/',
    "socialLinkAndroid": 'https://wa.me/',
    "socialLinkWeb": 'https://wa.me/',
    "socialIcon": '5',
    "socialAddedTo": false,
    "socialIsSelect": false,
    "value": null,
    "messageAR":'افتح الواتساب واذهب الى الاعدادات اضغط على ملفك الشخصي في الاعلى وقم بنسخ ولصق الرقم مع رمز البلد.',
    "messageEN":'Open WhatsApp and go to Settings Tap your profile at the top and copy/paste number. include your country code!'

  },
  {
    "id":5,
    "socialName": 'Snapchat',
    "socialLinkIos": 'snapchat://add/',
    "socialLinkAndroid": 'snapchat://add/',
    "socialLinkWeb": 'snapchat://add/',
    "socialIcon": '4',
    "socialAddedTo": false,
    "socialIsSelect": false,
    "value": null,
    "messageAR":'افتح السناب شات واضغط على صورة حسابك, سيضهر الحساب تحت اسم حسابك',
    "messageEN":'Open Snapchat and tap your profile picture in the top left corner Your username is below your Snapchat name.'


  },
  {
    "id":6,
    "socialName": 'Tik Tok',
    "socialLinkIos": 'https://www.tiktok.com/@',
    "socialLinkAndroid": 'https://www.tiktok.com/@',
    "socialLinkWeb": 'https://www.tiktok.com/@',
    "socialIcon": '6',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'افتح تطبيق التيك توك ثم اضغط على "صفحتي" سيضهر اسم المستخدم تحت الصورة الشخصية.',
    "messageEN":'Open Tik Tok and tap your profile picture in the top left corner Your username is below your Snapchat name.'


  },
  {
    "id":7,
    "socialName": 'Telegram',
    "socialLinkIos": 'https://telegram.me/',
    "socialLinkAndroid": 'https://telegram.me/',
    "socialLinkWeb": 'https://telegram.me/',
    "socialIcon": '7',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'افتح الواتساب واذهب الى الاعدادات اضغط على ملفك الشخصي في الاعلى وقم بنسخ ولصق الرقم مع رمز البلد.',
    "messageEN":'Open Telegram and tap your profile picture in the top left corner Your username is below your Snapchat name.'


  },
  {
    "id": 8,
    "socialName": 'Facebook',
    "socialLinkIos": 'https://www.facebook.com/',
    "socialLinkAndroid": 'https://www.facebook.com/',
    "socialLinkWeb": 'https://www.facebook.com/',
    "socialIcon": '1',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'اذهب الى موقع facebook.com وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN":'Go to facebook.com and open your Facebook profile or page Then copy and past the url link here.'

  },

  {
    "id":9,
    "socialName": 'Phone number',
    "socialLinkIos": 'tel:',
    "socialLinkAndroid": 'tel:',
    "socialLinkWeb": 'tel:',
    "socialIcon": '9',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'ادخل رقم هاتفك بدون الرقم صفر البدائي مع رمز البلد (مثال +964 لدولة العراق)',
    "messageEN":'Enter your phone number with country code.'


  },
  {
    "id":10,
    "socialName": 'YouTube',
    "socialLinkIos": 'https://www.youtube.com/channel/',
    "socialLinkAndroid": 'https://www.youtube.com/channel/',
    "socialLinkWeb": 'https://www.youtube.com/channel/',
    "socialIcon": '10',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'اذهب الى قناتك او الفبديو, انقر على النقاط الثلاث في الاعلى ثم مشاركة, قم بنسخ ولصق الرابط هنا.',
    "messageEN":'Go to your channel or video Tap the three dots in the top right corner and tap share Copy/past the link here'


  },
  {
    "id":12,
    "socialName": 'custom link',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": '',
    "socialIcon": '12',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'افتح تطبيق او موقع وقم بنسخ ولصق الرابط هنا, هذا الرابط يسمح لك بمشاركة اي شي لحظيا.',
    "messageEN":'open your app or website link and copy/past here. This link allows your to instantly share anything.'


  },
  {
    "id":11,
    "socialName": 'Skyp',
    "socialLinkIos": 'skype:',
    "socialLinkAndroid": 'skype:',
    "socialLinkWeb": 'skype:',
    "socialIcon": '11',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'اذهب الى موقع SKYP وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN":''


  },
  {
    "id":13,
    "socialName": 'Asiahawala',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": ':',
    "socialIcon": '13',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'',
    "messageEN":''


  },
  {
    "id":14,
    "socialName": 'Zain Cash',
    "socialLinkIos": '',
    "socialLinkAndroid": '',
    "socialLinkWeb": ':',
    "socialIcon": '14',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'',
    "messageEN":''

  },
  {
    "id":15,
    "socialName": 'LinkedIn',
    "socialLinkIos": 'http://ca.linkedin.com/in/',
    "socialLinkAndroid": 'http://ca.linkedin.com/in/',
    "socialLinkWeb": 'http://ca.linkedin.com/in/',
    "socialIcon": '15',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'اذهب الى موقع linkedin.com وافتح صفحتك الشخصية وقم بنسخ الرابط ولصقه هنا',
    "messageEN":'Go to LinkedIn.com and open your LinkedIn profile or page Then copy and past the url link here.'
  },
  {
    "id":16,
    "socialName": 'Viber',
    "socialLinkIos": 'viber://add?number=',
    "socialLinkAndroid": 'viber://add?number=',
    "socialLinkWeb": 'viber://add?number=',
    "socialIcon": '16',
    "socialIsSelect": false,
    "socialAddedTo": false,
    "value": null,
    "messageAR":'ادخل رقم هاتفك بدون الرقم صفر البدائي مع رمز البلد (مثال +964 لدولة العراق)',
    "messageEN":'Open v and go to Settings Tap your profile at the top and copy/paste number. include your country code!'

  },
];


const kAdvanceConfig = {
  "DefaultLanguage": "en",
  "IsRequiredLogin": true,
};
ThemeData themeData = ThemeData(
  primaryColor:Color(0xFFE3C397) ,
    primarySwatch: customColor,
    textSelectionColor:Colors.white ,
    textSelectionHandleColor:Colors.white ,
    fontFamily: 'LBC', textTheme: TextTheme(

));

/// Logging config
const kLOG_TAG = "[MUBRM]";
const kLOG_ENABLE = true;

printLog(String fun, dynamic data) {
  if (kLOG_ENABLE) {
    print("[${DateTime.now().toUtc()}]$kLOG_TAG${data.toString()}[$fun]");
  }
}

const kURL_FCM = 'https://fcm.googleapis.com/fcm/send';

const kSERVER_KEY =
    'key=AAAAWKqc3SA:APA91bEqSkn6la1DP-ciz0hLvlxzcXNGLBFmwQ43or6bmupm58yUCdKxY-8yAetZzYmsik5qXsk7Cjrv7rIitlRCv1Cb2iU3ySq8DCKnTuiBEshVD-KysjtDlNIFhZFzA5hw4QONhZ69';

setSearchParam(String caseName) {
  List<String> caseSearchList = List();
  String temp = "";
  for (int i = 0; i < caseName.length; i++) {
    temp = temp + caseName[i];
    caseSearchList.add(temp);
  }
  return caseSearchList;
}

class LoginSMSConstants {
  static const String countryCodeDefault = 'IQ';
  static const String dialCodeDefault = '+964';
  static const String nameDefault = 'Iraq';
}

const String kLogo = 'images/PNG/logo.jpg';
