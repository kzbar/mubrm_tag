import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mubrm_tag/confing/general.dart';

class AppUser {
  String id;
  String name;
  String email;
  String phoneNumber;
  String token;
  Map<String,dynamic> picture;
  Map<String,dynamic> socialMediaSelected;
  String tenantId;
  bool loggedIn;
  Timestamp created;

  AppUser.fromFirebaseEmailFirstTime(User user, Map<String, dynamic> map) {
    try {
      id = user.uid;
      name = map['name'];
      email = user.email;
      tenantId = user.tenantId;
      phoneNumber = user.phoneNumber;
      token = user.refreshToken;
      picture = map['image'];
      loggedIn = true;
      created = Timestamp.now();
      socialMediaSelected = map['socialMediaSelected'];
    } catch (error) {
      printLog('AppUserClass-fromFirebaseEmailFirstTime', error.toString());
    }
  }
  AppUser.fromFirebaseEmailLogin(User user, Map<String, dynamic> map) {
    try {
      id = user.uid;
      name = map['name'];
      email = user.email;
      tenantId = user.tenantId;
      phoneNumber = user.phoneNumber;
      token = user.refreshToken;
      picture = map['image'];
      loggedIn = true;
      socialMediaSelected = map['socialMediaSelected'];
    } catch (error) {
      printLog('AppUserClass-fromFirebaseEmailLogin', error.toString());
    }
  }

  AppUser.fromFireStoreDataBase(Map<String, dynamic> map) {
    try{
      id = map['id'];
      name = map['name'];
      email = map['email'];
      tenantId = map['tenantId'];
      phoneNumber = map['phoneNumber'];
      token = map['token'];
      picture = map['picture'];
      loggedIn = map['loggedIn'];
      socialMediaSelected = map['socialMediaSelected'];

    }catch(error){
      printLog('AppUserClass-fromFireStoreDataBase', error.toString());
    }

  }

  Map<String, dynamic> appUserToJsonFirstTime() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'picture': picture,
      'tenantId': tenantId,
      'loggedIn': loggedIn,
      'created': created,
      'token': token,
      'socialMediaSelected': socialMediaSelected,
    };
  }
}
