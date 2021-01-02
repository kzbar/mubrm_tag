import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/services/index.dart';
import 'dart:async';

class FireBaseServices implements BaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final tag = 'FireBaseServices';
  String _chars = '1234567890';
  Random _rnd = Random();
  List<Map<String,dynamic>> kSocialMediaSelectedList = [
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

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Future<AppUser> addUser({AppUser appUser}) async {
    try {
      DocumentSnapshot documentSnapshot = await fireStore.collection('users').doc(appUser.id).get();
      if (documentSnapshot.exists) {
        printLog(tag, 'exists');
        return AppUser.fromFireStoreDataBase(documentSnapshot.data());
      } else {
        printLog(tag, 'not exists');
        bool nameIsExits = await checkUserNameIsExist(nameId: appUser.nameId);
        if(nameIsExits){
          await fireStore
              .collection('users')
              .doc(appUser.id)
              .set(appUser.appUserToJsonFirstTimeWithRandomNameId(getRandomString(2)));
        }else{
          await fireStore
              .collection('users')
              .doc(appUser.id)
              .set(appUser.appUserToJsonFirstTime());
        }
        await FirebaseFirestore.instance.collection('users').doc(appUser.id).collection('socialMediaSelectedList').doc('1').set(appUser.socialMediaSelected);
        kSocialMediaSelectedList.map((e) async{
          if(e['id']==1){
            printLog(tag, 'exists');
          }else{
            await FirebaseFirestore.instance.collection('users').doc(appUser.id).collection('socialMediaSelectedList').doc('${e['id']}').set(e);
          }
        }).toList();
        DocumentSnapshot documentSnapshot = await fireStore.collection('users').doc(appUser.id).get();
        return AppUser.fromFireStoreDataBase(documentSnapshot.data());
      }
    } on PlatformException catch (error) {
      printLog(tag, error.message);
      rethrow;
    } catch (error) {
      printLog(tag, error.toString());
      rethrow;
    }
  }
  Future<bool> checkUserNameIsExist({String nameId}) async{
    bool isExit = false;
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      for(int i = 0 ; i < value.docs.length ; i++){
        if(value.docs[i].data().containsValue(nameId)){
          isExit = true;
          break;
        }else{
          isExit = false;
          break;
        }
      }
    });
    return isExit;
  }

  @override
  Future<void> forgetPassword({Map<String, dynamic> json}) async {
    try {

      _auth.setLanguageCode(json['lang']);
      await  _auth.sendPasswordResetEmail(email: json['email'].toString().trim());
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<AppUser> login({Map<String, dynamic> json}) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: json['email'].toString().trim(),
        password: json['password'].toString().trim(),
      ))
          .user;
      DocumentSnapshot documentSnapshot =
          await fireStore.collection('users').doc(user.uid).get();
      if (documentSnapshot.exists) {
        return AppUser.fromFireStoreDataBase(documentSnapshot.data());
      } else {
        return null;
      }
    } on PlatformException catch (error) {
      printLog(tag, error.message);
      rethrow;
    } catch (error) {
      printLog(tag, error.toString());
      rethrow;
    }
  }

  @override
  Future<User> singUp({Map<String, dynamic> json}) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: json['email'].toString().trim(),
        password: json['password'].toString().trim(),
      ))
          .user;
      return user;
    } on PlatformException catch (error) {
      printLog(tag, error.message);
      rethrow;
    } catch (error) {
      printLog(tag, error.toString());
      rethrow;
    }
  }

  @override
  Future<AppUser> upData({Map<String, dynamic> json}) async {
    try {
      printLog(tag,json['password'] );

      if (json['password'].toString().length != 0) {
        if (_auth.currentUser != null){
          printLog(tag,json['password'].toString().trim() );

          await _auth.currentUser.updatePassword(json['password'].toString().trim());
        }
        printLog(tag, 'updatePassword');

      }
      await fireStore.collection('users').doc(json['id']).update(json);
      DocumentSnapshot documentSnapshot =
          await fireStore.collection('users').doc(json['id']).get();
      return AppUser.fromFireStoreDataBase(documentSnapshot.data());
    } on PlatformException catch (error) {
      printLog(tag, error.message);
      rethrow;
    } catch (error) {
      printLog(tag, error.toString());
      rethrow;
    }
  }

  @override
  Future<void> logout({String id}) {
    return _auth.signOut();
  }

  @override
  Future<User> singInGoogle({GoogleAuthCredential userCredential}) async{
    try {
      final User user = (await _auth.signInWithCredential(userCredential)).user;
      return user;
    } on PlatformException catch (error) {
      printLog(tag, error.message);
      rethrow;
    } catch (error) {
      printLog(tag, error.toString());
      rethrow;
    }

  }


}
