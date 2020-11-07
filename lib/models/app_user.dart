import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mubrm_tag/confing/general.dart';


/// app user object
class AppUser {
  String id;
  String name;
  String nameId;
  String email;
  String phoneNumber;
  String token;
  Map<String,dynamic> picture;
  Map<String,dynamic> socialMediaSelected;
  String tenantId;
  bool loggedIn;
  bool profileIsPublic = false;
  Timestamp created;

  AppUser.fromFirebaseEmailFirstTime(User user, Map<String, dynamic> map) {
    try {
      id = user.uid;
      name = map['name'];
      nameId = user.email.split('@')[0];
      email = user.email;
      tenantId = user.tenantId;
      phoneNumber = user.phoneNumber;
      token = user.refreshToken;
      picture = map['image'];
      loggedIn = true;
      created = Timestamp.now();
      socialMediaSelected = map['socialMediaSelected'];
      profileIsPublic= map['profileIsPublic'] ?? false;
    } catch (error) {
      printLog('AppUserClass-fromFirebaseEmailFirstTime', error.toString());
    }
  }

  AppUser.fromFirebaseEmailLogin(User user, Map<String, dynamic> map) {
    try {
      id = user.uid;
      name = map['name'];
      nameId = user.email.split('@')[0];
      email = user.email;
      tenantId = user.tenantId;
      phoneNumber = user.phoneNumber;
      token = user.refreshToken;
      picture = map['image'];
      loggedIn = true;
      socialMediaSelected = map['socialMediaSelected'];
      profileIsPublic= map['profileIsPublic'] ;

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
      nameId = map['nameId'];
      token = map['token'];
      picture = map['picture'];
      loggedIn = map['loggedIn'];
      socialMediaSelected = map['socialMediaSelected'];
      profileIsPublic= map['profileIsPublic'];
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
      'profileIsPublic': profileIsPublic,
      'nameId':nameId
    };
  }

  Map<String, dynamic> appUserToJsonFirstTimeWithRandomNameId(String string) {
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
      'profileIsPublic': profileIsPublic,
      'nameId':nameId+string
    };
  }

}
