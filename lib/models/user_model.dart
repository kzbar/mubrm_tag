import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/services/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel with ChangeNotifier {
  bool loggedIn = false;

  final Services _service = Services();

  /// firebase user object to get user info
  User userFireBase;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// user app object
  AppUser userApp;

  /// firebase firestore database
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  UserModel() {
    try {
      getUserFromLocal();
    } catch (error) {
      printLog('getUserFromLocal', error.toString());
    }
  }
  /// function to save  user info in   device
  Future<void> saveUser(AppUser user) async {
    printLog('saveUser', '${user.id}');
    final LocalStorage storage = LocalStorage("mubrm_tag");
    try {
      // save to Preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);
      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem('userInfo', user.appUserToJsonFirstTime());
      }
    } catch (err) {
      printLog('saveUser', err);
    }
  }

  Future<void> singUp(
      {Map<String, dynamic> json,
      Function success,
      Function platformException,
      Function fail}) async {
    printLog('singUp', '$json');
    try {
      userFireBase = await _service.singUp(json: json);
      success(userFireBase);
      loggedIn = true;
      notifyListeners();
    } on PlatformException catch (err) {
      platformException(err);
    } catch (e) {
      fail(e);
    }
  }
  /// function to add   user  info to database
  Future<void> addUserToDatabase(
      {AppUser user,
      Function success,
      Function platformException,
      Function fail}) async {
    try {
      userApp = await _service.addUser(appUser: user);
      await saveUser(userApp);
      success(userApp);
      loggedIn = true;
      notifyListeners();
    } on PlatformException catch (err) {
      platformException(err);
    } catch (e) {
      fail(e);
    }
  }

  Future<void> loginIn(
      {Map<String, dynamic> json,
      Function success,
      Function platformException,
      Function fail}) async {
    try {
      userApp = await _service.login(json: json);
      if (userApp != null) {
        loggedIn = true;
        await saveUser(userApp);
        success(userApp);
      } else {
        fail('User not exists');
      }
    } on PlatformException catch (err) {
      platformException(err);
    } catch (error) {
      fail(error);
    }
  }

  Future<void> forgetPassword(
      {Map<String, dynamic> json,
      Function success,
      Function platformException,
      Function fail}) async {
    try {
      await _service.forgetPassword(json: json);
      success('تم ارسال كود تأكيد الى بريدك الالكتروني تححقق من الآن');
    } on PlatformException catch (err) {
      platformException(err);
    } catch (error) {
      fail(error);
    }
  }

  Future<void> sinInWithGoogle(
      {Function success, Function platformException, Function fail}) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        userFireBase = await _service.singInGoogle(userCredential: credential);
        success(userFireBase);
        loggedIn = true;
        notifyListeners();
      } on PlatformException catch (err) {
        platformException(err);
      } catch (e) {
        fail(e);
      }
    } catch (error) {
      fail(error);
    }
  }
  /// update user info
  Future<void> upDateUserInfo(
      {Map<String, dynamic> json,
      Function success,
      Function platformException,
      Function fail}) async {
    try {
      userApp = await _service.upData(json: json);
      if (userApp != null) {
        await saveUser(userApp);
        success(userApp);
      } else {
        fail('User not exists');
      }
    } on PlatformException catch (err) {
      platformException(err);
    } catch (error) {
      fail(error);
    }
  }

  /// get user info if user  login
  Future<void> getUserFromLocal({Function success, Function fail}) async {
    final LocalStorage storage = LocalStorage("mubrm_tag");
    try {
      userFireBase = _auth.currentUser;
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem("userInfo");
        if (json != null) {
          userApp = AppUser.fromFireStoreDataBase(json);
          printLog('getUserFromLocal', userApp.id);
          loggedIn = true;
          //success(userApp);
          notifyListeners();
        }
      }
    } catch (err) {
      //fail(err);
      print(err);
    }
  }

  Future logOut({Function success}) async {
    userApp = null;
    loggedIn = false;

    final LocalStorage storage = LocalStorage("mubrm_tag");
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem("userInfo");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
      }
      await _service.logout(id: userFireBase.uid);
      success('ok');
      notifyListeners();
    } catch (e) {}
  }
}
