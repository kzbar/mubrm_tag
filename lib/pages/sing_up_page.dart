import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/pages/home_page.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:provider/provider.dart';

class SingUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SingUpPage();
  }
}

class _SingUpPage extends State<SingUpPage> with TickerProviderStateMixin {
  File _image;
  String imageUrl;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  AnimationController _loginButtonController;
  AnimationController _loginGoogleButtonController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 900,
              decoration: kBoxDecoration,
            ),
            Column(
              children: [
                SizedBox(
                  height: 36,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
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
                    S.of(context).singUpTitle,
                    style: kTextStyleTile,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          kGetImage().then((value) {
                            setState(() {
                              _image = File(value.path);
                            });
                          });
                        },
                        child: Container(
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
                              : Image.asset(
                                  'images/PNG/camera.png',
                                  width: 120,
                                  height: 120,
                                ),
                          width: 170,
                          height: 170,
                          padding: EdgeInsets.all(_image != null ? 0.0 : 24.0),
                          margin: EdgeInsets.only(top: 48),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        S.of(context).profileImage,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        child: FormBuilder(
                          key: _fbKey,
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
                                  keyboardType: TextInputType.emailAddress,
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText:
                                            S.of(context).errorTextRequired),
                                    FormBuilderValidators.minLength(8,
                                        errorText: S
                                            .of(context)
                                            .errorTextMinLength(8)),
                                    // FormBuilderValidators.pattern(
                                    //     "^[a-zA-Z0-9][a-zA-Z0-9\-\.]*[a-zA-Z0-9]\$",
                                    //     errorText: S.of(context).errorTextFormat),
                                  ],
                                  attribute: 'name',
                                  cursorColor: Colors.black,
                                  style: kTextStyleEditText,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).name,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
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
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText:
                                            S.of(context).errorTextRequired),
                                    FormBuilderValidators.email(
                                        errorText:
                                            S.of(context).errorTextEmail),
                                  ],
                                  attribute: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.black,
                                  style: kTextStyleEditText,
                                  decoration: InputDecoration(
                                      hintText: S.of(context).email,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
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
                                  attribute: 'password',
                                  obscureText: true,
                                  validators: [
                                    FormBuilderValidators.required(
                                        errorText:
                                            S.of(context).errorTextRequired),
                                    FormBuilderValidators.minLength(8,
                                        errorText: S
                                            .of(context)
                                            .errorTextMinLength(8)),
                                  ],
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
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _fbKey.currentState.save();
                    if (_fbKey.currentState.validate()) {
                      singUpWithEmail(context);
                    }
                  },
                  child: StaggerAnimation(
                    buttonController: _loginButtonController.view,
                    titleButton: S.of(context).continueTo,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ///login with google
                Visibility(
                  visible: Platform.isAndroid,
                  child: InkWell(
                    onTap: () {
                      loginWithGoogle(context);
                    },
                    child: StaggerAnimation(
                      begin: 200,
                      buttonController: _loginGoogleButtonController.view,
                      titleButton: S.of(context).continueWithGoogle,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void singUpWithEmail(BuildContext context) {
    Map<String, dynamic> map = _fbKey.currentState.value;
    _playAnimation('singUp');
    Provider.of<UserModel>(context, listen: false).singUp(
        json: map,
        success: (User user) {
          Provider.of<UserModel>(context, listen: false).loginIn(
              json: map,
              success: (user) {},
              fail: (error) {},
              platformException: (error) {});
          printLog('singUp', user.uid);
          if (_image != null) {
            kUploadImage(
                image: _image,
                userId: user.uid,
                fail: (error) {
                  printLog('kUploadImage', error.toString());
                  _stopAnimation('singUp');
                  _showMessage(error.toString(), context);
                },
                success: (url) {
                  Map<String, dynamic> socialMediaSelected = {
                    "id": 1,
                    "socialName": 'Email',
                    "socialLinkIos": 'mailto:',
                    "socialLinkAndroid": 'mailto:',
                    "socialLinkWeb": 'mailto:',
                    "socialIcon": '8',
                    "socialIsSelect": false,
                    "socialAddedTo": true,
                    "value": user.email,
                    "messageAR":
                        'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
                    "messageEN":
                        'input your email address. This email can be the same of different from the one used for your account sign up.'
                  };
                  map['image'] = url;
                  map['socialMediaSelected'] = socialMediaSelected;
                  AppUser _user = AppUser.fromFirebaseEmailFirstTime(user, map);
                  Provider.of<UserModel>(context, listen: false).addUserToDatabase(
                      user: _user,
                      fail: (error) {
                        _stopAnimation('singUp');
                        _showMessage(error.toString(), context);

                        printLog('fail addUser', error.toString());
                      },
                      success: (AppUser appUser) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
                      },
                      platformException: (error) {
                        _stopAnimation('singUp');
                        _showMessage(error.toString(), context);

                        printLog('platformException addUser', error.toString());
                      });
                },
                progress: (p) {
                  printLog('progress', p.toString());
                });
          } else {
            Map<String, dynamic> socialMediaSelected = {
              "id": 1,
              "socialName": 'Email',
              "socialLinkIos": 'mailto:',
              "socialLinkAndroid": 'mailto:',
              "socialLinkWeb": 'mailto:',
              "socialIcon": '8',
              "socialIsSelect": false,
              "socialAddedTo": true,
              "value": user.email,
              "messageAR":
                  'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
              "messageEN":
                  'input your email address. This email can be the same of different from the one used for your account sign up.'
            };
            Map<String, dynamic> _defImage = {};
            _defImage['image'] = defImage;
            _defImage['image_path'] = user.uid;
            map['image'] = _defImage;
            map['socialMediaSelected'] = socialMediaSelected;
            AppUser _user = AppUser.fromFirebaseEmailFirstTime(user, map);
            Provider.of<UserModel>(context, listen: false).addUserToDatabase(
                user: _user,
                fail: (error) {
                  _stopAnimation('singUp');
                  _showMessage(error.toString(), context);
                  printLog('addUser', error.toString());
                },
                success: (AppUser appUser) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },platformException: (error){
              _stopAnimation('singUp');

              _showMessage(error.toString(), context);

              printLog('addUser', error.toString());

            });

          }
        },
        fail: (error) {
          _stopAnimation('singUp');
          _showMessage(error.toString(), context);
          printLog('singUp', error.toString());
        },
        platformException: (error) {
          _stopAnimation('singUp');
          _showMessage(error.toString(), context);
          printLog('singUp', error.toString());
        });
  }

  void loginWithGoogle(BuildContext context) async {
    _playAnimation('GOOGLE');
    Provider.of<UserModel>(context, listen: false).sinInWithGoogle(
        success: (User user) {
      Map<String, dynamic> map = {};
      Map<String, dynamic> socialMediaSelected = {
        "id": 1,
        "socialName": 'Email',
        "socialLinkIos": 'mailto:',
        "socialLinkAndroid": 'mailto:',
        "socialLinkWeb": 'mailto:',
        "socialIcon": '8',
        "socialIsSelect": false,
        "socialAddedTo": true,
        "value": user.email,
        "messageAR":
            'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
        "messageEN":
            'input your email address. This email can be the same of different from the one used for your account sign up.'
      };
      Map<String, dynamic> _defImage = {};
      _defImage['image'] = user.photoURL;
      _defImage['image_path'] = user.uid;
      map['image'] = _defImage;
      map['socialMediaSelected'] = socialMediaSelected;
      map['name'] = user.displayName;

      AppUser _user = AppUser.fromFirebaseEmailFirstTime(user, map);
      Provider.of<UserModel>(context, listen: false).addUserToDatabase(
          user: _user,
          fail: (error) {
            _stopAnimation('GOOGLE');
            _showMessage(error.toString(), context);

            printLog('fail addUser', error.toString());
          },
          success: (AppUser appUser) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          },
          platformException: (error) {
            _stopAnimation('GOOGLE');
            _showMessage(error.toString(), context);

            printLog('platformException addUser', error.toString());
          });
    }, fail: (error) {
      _stopAnimation('GOOGLE');
      if (error.toString().startsWith('[firebase_auth/user-not-found]')) {
        _showMessage(S.of(context).restPasswordError, context);
      } else if (error
          .toString()
          .startsWith('[firebase_auth/wrong-password]')) {
        _stopAnimation('GOOGLE');
        _showMessage(S.of(context).wrongPassword, context);
      } else {
        _stopAnimation('GOOGLE');
        _showMessage(error.toString(), context);
      }
    }, platformException: (error) {
      _stopAnimation('GOOGLE');
      _showMessage(error.toString(), context);
    });
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
    _loginGoogleButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    super.initState();
  }

  Future<Null> _playAnimation(type) async {
    try {
      if (type == 'GOOGLE') {
        await _loginGoogleButtonController.forward();
      } else {
        await _loginButtonController.forward();
      }
    } on TickerCanceled {
      printLog('_playAnimation', ' error');
    }
  }

  Future<Null> _stopAnimation(type) async {
    try {
      if (type == ' GOOGLE') {
        await _loginGoogleButtonController.reverse();
      } else {
        await _loginButtonController.reverse();
      }
    } on TickerCanceled {
      printLog('_stopAnimation', ' error');
    }
  }

  void _showMessage(String message, context) {
    final snackBar = SnackBar(
      content: Text(
        '$message !',
        style: kTextStyle,
      ),
    );
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
