


import 'package:firebase_auth/firebase_auth.dart';
import 'package:mubrm_tag/models/app_user.dart';

import 'firebase_services.dart';

abstract class BaseServices {

  Future<AppUser> login({Map<String, dynamic> json});

  Future<User> singInGoogle({GoogleAuthCredential userCredential});

  Future<AppUser> upData({Map<String, dynamic> json});

  Future<User> singUp({Map<String, dynamic> json});

  Future<void> forgetPassword({Map<String, dynamic> json});

  Future<AppUser> addUser({AppUser appUser});



  Future<void> logout({String id});

}
class Services implements BaseServices {
  BaseServices serviceApi;

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();
  void setAppConfig() {
    serviceApi = FireBaseServices();
  }

  @override
  Future<AppUser> addUser({AppUser appUser,Map<String, dynamic> json}) {
    return serviceApi.addUser(appUser: appUser);
  }

  @override
  Future<void> forgetPassword({Map<String,dynamic > json}) {
    return serviceApi.forgetPassword(json: json);
  }

  @override
  Future<AppUser> login({Map<String,dynamic > json}) {
    return serviceApi.login(json: json);
  }
  @override
  Future<AppUser> upData({Map<String,dynamic > json}) {
    return serviceApi.upData(json: json);
  }

  @override
  Future<User> singUp({Map<String,dynamic > json}) {
    return serviceApi.singUp(json: json);
  }

  @override
  Future<void> logout({String id}) {
    // TODO: implement logout
    return serviceApi.logout(id: id);
  }

  @override
  Future<User> singInGoogle({GoogleAuthCredential userCredential}) {
    return serviceApi.singInGoogle(userCredential: userCredential);
  }
}