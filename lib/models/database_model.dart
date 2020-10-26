


import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/database/database.dart';
import 'package:mubrm_tag/model/social_media.dart';

class DatabaseModel  with ChangeNotifier{
  List<SocialMedia> list = [];
  SocialMedia socialMediaSelected;

  Future<void> getSocialMediaList()async{
    DBProvider.db.getAllMediaSelected().then((value) {
      list = value;
      notifyListeners();
    });
  }
  Future<void> getSocialMediaSelected(int id)async{
    list.map((e) {
      if(e.id == id){
        socialMediaSelected = e;
        notifyListeners();
      }
    }).toList();
  }
  Future<void> insert(SocialMedia _media,String value)async{

    SocialMedia media = SocialMedia(
      socialName: _media.socialName,
      id: _media.id,
      socialIcon: _media.socialIcon,
      socialIsSelect: false,
      socialAddedTo: true,
      socialLinkAndroid: _media.socialLinkAndroid,
      socialLinkWeb: _media.socialLinkWeb,
      socialLinkIos: _media.socialLinkIos,
      value: value,
    );
    var raw =  await DBProvider.db.newSocialMediaSelected(media);
    var raw2 =  await DBProvider.db.updateClient(media);
    
    DBProvider.db.getAllMediaSelected().then((value) {
      list = value;
      notifyListeners();
    });
    printLog('insert', raw);
  }
  Future<void> update(SocialMedia _media,String value)async{

    SocialMedia media = SocialMedia(
      socialName: _media.socialName,
      id: _media.id,
      socialIcon: _media.socialIcon,
      socialIsSelect: false,
      socialAddedTo: true,
      socialLinkAndroid: _media.socialLinkAndroid,
      socialLinkWeb: _media.socialLinkWeb,
      socialLinkIos: _media.socialLinkIos,
      value: value,
    );
    var raw =  await DBProvider.db.updateMediaSelected(media);
    var raw2 =  await DBProvider.db.updateClient(media);
    DBProvider.db.getAllMediaSelected().then((value) {
      list = value;
      notifyListeners();
    });
    printLog('insert', raw);
  }
  Future<void> updateValue(SocialMedia _media,String value)async{

    SocialMedia media = SocialMedia(
      socialName: _media.socialName,
      id: _media.id,
      socialIcon: _media.socialIcon,
      socialIsSelect: false,
      socialAddedTo: true,
      socialLinkAndroid: _media.socialLinkAndroid,
      socialLinkWeb: _media.socialLinkWeb,
      socialLinkIos: _media.socialLinkIos,
      value: value,
    );
    var raw =  await DBProvider.db.updateMediaSelected(media);
    var raw2 =  await DBProvider.db.updateClient(media);
    DBProvider.db.getAllMediaSelected().then((value) {
      list = value;
      notifyListeners();
    });
    printLog('insert', raw);
  }
}