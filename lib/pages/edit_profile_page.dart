import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:mubrm_tag/widgets/row_item_edit.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage>
    with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  AnimationController _loginButtonController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Function function;
  File _image;
  String imageUrl;
  bool imageUpload = false;
  double imageUploadSize;
  List<SocialMedia> _list = [];
  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          ///background page
          Container(
            height: 900,
            decoration: kBoxDecoration,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 36,
                ),
                InkWell(
                  onTap: () {
                    if (!imageUpload) Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 12, bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Theme.of(context).primaryColor,
                      size: 48,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    S.of(context).editAccount,
                    style: kTextStyleTile,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          kGetImage().then((value) async {
                            setState(() {
                              _image = File(value.path);
                              imageUpload = true;
                            });
                            kUploadImage(
                                image: _image,
                                userId: user.id,
                                name: user.picture['image_path'],
                                success: (url) {
                                  setState(() {
                                    imageUpload = false;

                                    imageUrl = url['image'];
                                  });
                                },
                                fail: (error) {
                                  imageUpload = false;

                                  printLog('kGetImage', error.toString());
                                },
                                progress: (d) {
                                  setState(() {
                                    imageUploadSize = d;
                                  });
                                  printLog('kGetImage', d);
                                });
                          });
                        },
                        child: imageUpload
                            ? Stack(
                                children: [
                                  Container(
                                    child: CircularProgressIndicator(),
                                    width: 140,
                                    height: 140,
                                    padding: EdgeInsets.all(12.0),
                                    margin: EdgeInsets.only(top: 48),
                                  ),
                                  Container(
                                    child: CircularProgressIndicator(
                                      value: imageUploadSize,
                                    ),
                                    width: 140,
                                    height: 140,
                                    padding: EdgeInsets.all(6.0),
                                    margin: EdgeInsets.only(top: 48),
                                  ),
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: _image != null
                                    ? ClipOval(
                                        child: Image.file(
                                          _image,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : user != null
                                        ? ClipOval(
                                            child: Image.network(
                                              user.picture['image'],
                                              width: 170,
                                              height: 170,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Image.asset(
                                            'images/PNG/camera.png',
                                            width: 120,
                                            height: 120,
                                          ),
                                width: 170,
                                height: 170,
                                padding: EdgeInsets.all(6.0),
                                margin: EdgeInsets.only(top: 48),
                              ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        S.of(context).editImage,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: FormBuilder(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 24, right: 24, bottom: 24),
                                padding: EdgeInsets.only(
                                  right: 12,
                                  left: 12,
                                ),
                                height: 50,
                                decoration: kBoxDecorationEditText,
                                child: FormBuilderTextField(
                                  attribute: 'name',
                                  initialValue:
                                      user != null ? user.name : 'Non',
                                  cursorColor: Colors.black,
                                  style: kTextStyleEditText,
                                  validators: [
                                    FormBuilderValidators.pattern(
                                        "^[a-zA-Z0-9][a-zA-Z0-9\-\.]*[a-zA-Z0-9]\$",
                                        errorText: S.of(context).errorTextFormat),
                                  ],
                                  decoration: InputDecoration(
                                      hintText: S.of(context).name,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 24, right: 24, bottom: 24),
                                padding: EdgeInsets.only(
                                  right: 12,
                                  left: 12,
                                ),
                                height: 50,
                                decoration: kBoxDecorationEditText,
                                child: FormBuilderTextField(
                                  attribute: 'email',
                                  initialValue: user != null
                                      ? user.email
                                      : 'test@gmail.com',
                                  cursorColor: Colors.black,
                                  style: kTextStyleEditText,
                                  onChanged: (text) {},
                                  decoration: InputDecoration(
                                      hintText: S.of(context).email,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 24, right: 24, bottom: 0),
                                padding: EdgeInsets.only(
                                  right: 12,
                                  left: 12,
                                ),
                                height: 50,
                                decoration: kBoxDecorationEditText,
                                child: FormBuilderTextField(
                                  attribute: 'password',
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  style: kTextStyleEditText,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).password,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                          key: _fbKey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 12),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).makeProfilePublic,
                        style: kTextStyle.copyWith(
                            color: Colors.white, fontSize: 24),
                      ),
                      Expanded(
                        child: FormBuilderSwitch(

                          onChanged: (value) {},
                          activeColor: Theme.of(context).primaryColor,
                          inactiveThumbColor: Colors.grey,
                          attribute: 'value',
                          label: Text(''),
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24,right: 24,),
                  child:                 Text(
                    S.of(context).makeProfileMessage,
                    textAlign: TextAlign.center,
                    style: kTextStyle.copyWith(
                        color: Colors.white70, fontSize: 16),
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(left: 24,right: 24,top: 12),
                  child:                 Text(
                    'mubrmtag.com/#/${user.nameId}',
                    textAlign: TextAlign.center,
                    style: kTextStyle.copyWith(
                        color: Colors.white70, fontSize: 16),
                  ),

                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  S.of(context).socialMediaMyList,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                ..._list.map((e) {
                  return RowItem(
                    media: e,
                  );
                }).toList(),
                SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    _playAnimation();
                    _fbKey.currentState.save();
                    Map<String, dynamic> newMap = {};
                    newMap.addAll(_fbKey.currentState.value);
                    newMap['id'] = user.id;
                    print(newMap.toString());
                    if (imageUrl != null) {
                      Map<String, dynamic> image = {};
                      image['image'] = imageUrl;
                      image['image_path'] = user.picture['image_path'];
                      newMap['picture'] = image;
                    }
                    Provider.of<UserModel>(context, listen: false).upData(
                        json: newMap,
                        success: (user) {
                          _stopAnimation();
                          _showMessage(
                              S.of(context).dataUpdateSuccess, context);
                        },
                        fail: (error) {
                          _stopAnimation();
                          _showMessage(error.toString(), context);
                        },
                        platformException: (error) {
                          _stopAnimation();
                          _showMessage(error, context);
                        });
                  },
                  child: StaggerAnimation(
                    buttonController: _loginButtonController.view,
                    titleButton: S.of(context).save,
                  ),
                ),
                SizedBox(
                  height: 48,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection('socialMediaSelectedList')
        .get()
        .then((value) {
      value.docs.map((e) {
        setState(() {
          _list.add(SocialMedia.fromJsonFireStore(e.data(), e.id));
        });
      }).toList();
    });
    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        //isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      printLog('_playAnimation', ' error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        //isLoading = false;
      });
    } on TickerCanceled {
      printLog('_stopAnimation', ' error');
    }
  }

  void _showMessage(String message, context) {
    final snackBar = SnackBar(
      content: Text(
        '$message !',
        style: kTextStyleTile.copyWith(fontSize: 16),
      ),
    );
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
