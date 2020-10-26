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

  @override
  Future<AppUser> addUser({AppUser appUser, Map<String, dynamic> json}) async {
    try {
      DocumentSnapshot documentSnapshot = await fireStore.collection('users').doc(appUser.id).get();
      if (documentSnapshot.exists) {
        printLog(tag, 'exists');
        return AppUser.fromFireStoreDataBase(documentSnapshot.data());
      } else {
        printLog(tag, 'not exists');
        await fireStore
            .collection('users')
            .doc(appUser.id)
            .set(appUser.appUserToJsonFirstTime());
        await FirebaseFirestore.instance.collection('users').doc(appUser.id).collection('socialMediaSelectedList').doc().set(appUser.socialMediaSelected);
        kSocialList.map((e) async{
          if(e['id']==1){
            printLog(tag, 'exists');
          }else{
            await FirebaseFirestore.instance.collection('users').doc(appUser.id).collection('socialMediaSelectedList').doc().set(e);
          }
        }).toList();
        DocumentSnapshot documentSnapshot = await fireStore.collection('users').doc(appUser.id).get();
        return AppUser.fromFireStoreDataBase(documentSnapshot.data());
      }
    } on PlatformException catch (error) {
      printLog(tag, error);
      rethrow;
    } catch (error) {
      printLog(tag, error.message);
      rethrow;
    }
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

}
