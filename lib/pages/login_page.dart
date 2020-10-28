import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/pages/forget_page.dart';
import 'package:mubrm_tag/pages/sing_up_page.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:mubrm_tag/widgets/chang_lang.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController _loginButtonController;
  AnimationController _loginGoogleButtonController;
  TextEditingController controller  = TextEditingController();

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _loginGoogleButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    _loginGoogleButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: kBoxDecoration,
          child: FormBuilder(
            key: _fbKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ChangeLang(),
                SizedBox(
                  height: 24,
                ),

                Text(
                  S.of(context).welcome,
                  style: kTextStyleTile,
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  padding: EdgeInsets.only(
                    right: 12,
                    left: 12,
                  ),
                  height: 50,
                  decoration: kBoxDecorationEditText,
                  child: FormBuilderTextField(
                    controller: controller,
                    attribute: 'email',
                    cursorColor: Colors.black,
                    style: kTextStyleEditText,
                    autocorrect: false,
                    enableSuggestions: false,
                    validators: [
                      FormBuilderValidators.required(
                          errorText: S.of(context).errorTextRequired),
                      FormBuilderValidators.email(
                          errorText: S.of(context).errorTextEmail),
                    ],
                    onChanged: (text){
                      print(text);
                      setState(() {
                       // controller.text = text.toString().trim();
                      });
                    },
                    decoration: InputDecoration(
                        hintText: S.of(context).email,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 48),
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
                    validators: [
                      FormBuilderValidators.required(
                          errorText: S.of(context).errorTextRequired),
                    ],
                    decoration: InputDecoration(
                        hintText: S.of(context).password,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none),
                  ),
                ),
                /// login with email
                InkWell(
                  onTap: () {
                    _fbKey.currentState.save();
                    if (_fbKey.currentState.validate()) {
                      loginWithEmail(context);
                    }
                  },
                  child: StaggerAnimation(
                    buttonController: _loginButtonController.view,
                    titleButton: S.of(context).continueTo,
                  ),
                ),
                SizedBox(height: 12,),
                ///login with google
                InkWell(
                  onTap: () {
                    loginWithGoogle(context);
                  },
                  child: StaggerAnimation(
                    begin: 200,
                    buttonController: _loginGoogleButtonController.view,
                    titleButton: S.of(context).continueWithGoogle,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 0.0),
                  child: RichText(
                      key: UniqueKey(),
                      text: TextSpan(
                          text: ' ${S.of(context).doNotHaveAccount }',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'LBC'),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SingUpPage()));
                                },
                              text: ' ${S.of(context).singUp}',
                              style: TextStyle(
                                  color:Theme.of(context).primaryColor,
                                  fontSize: 22,
                                  fontFamily: 'LBC'),
                            )
                          ])),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ForgetPasswordPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                      S.of(context).forgetPassword,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _playAnimation(type) async {
    try {
      if(type == 'GOOGLE'){
        await _loginGoogleButtonController.forward();

      }else{
        await _loginButtonController.forward();

      }
    } on TickerCanceled {
      printLog('_playAnimation', ' error');
    }
  }

  Future<Null> _stopAnimation(type) async {
    try {
      if(type ==' GOOGLE'){
        await _loginGoogleButtonController.reverse();

      }else{
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

  void loginWithGoogle(BuildContext context) async{
    _playAnimation('GOOGLE');
    Provider.of<UserModel>(context, listen: false).sinInWithGoogle(
        success: (User user) {
          Map<String,dynamic> map ={};
          Map<String,dynamic> socialMediaSelected =  {
            "id": 1,
            "socialName": 'Email',
            "socialLinkIos": 'mailto:',
            "socialLinkAndroid": 'mailto:',
            "socialLinkWeb": 'mailto:',
            "socialIcon": '8',
            "socialIsSelect": false,
            "socialAddedTo": true,
            "value": user.email,
            "messageAR":'ادخل بريدك الخاص, هذا الاميل يمكن ان يكون نفس الاميل المسجل او بريد حسابي اخر.',
            "messageEN":'input your email address. This email can be the same of different from the one used for your account sign up.'
          };
          Map<String, dynamic> _defImage = {};
          _defImage['image'] = user.photoURL;
          _defImage['image_path'] = user.uid;
          map['image'] = _defImage;
          map['socialMediaSelected'] = socialMediaSelected;
          map['name'] = user.displayName;
          AppUser _user = AppUser.fromFirebaseEmailFirstTime(user, map);
          Provider.of<UserModel>(context,
              listen: false)
              .addUser(
              user: _user,
              fail: (error) {
                _stopAnimation('GOOGLE');
                _showMessage(
                    error.toString(), context);

                printLog('fail addUser',
                    error.toString());
              },
              success: (AppUser appUser) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HomePage()));
              },
              platformException: (error) {
                _stopAnimation('GOOGLE');
                _showMessage(
                    error.toString(), context);

                printLog(
                    'platformException addUser',
                    error.toString());
              });

        },
        fail: (error) {
          _stopAnimation('GOOGLE');
          if(error.toString().startsWith('[firebase_auth/user-not-found]')){
            _showMessage(S.of(context).restPasswordError, context);
          }else if(error.toString().startsWith('[firebase_auth/wrong-password]')){
            _showMessage(S.of(context).wrongPassword, context);
          }else{
            _showMessage(error.toString(), context);
          }

        },
        platformException: (error) {
          _stopAnimation('GOOGLE');
          _showMessage(error.toString(), context);
        });

  }

  void loginWithEmail(BuildContext context){
    _playAnimation('login');
    Provider.of<UserModel>(context, listen: false).loginIn(
        json: _fbKey.currentState.value,
        success: (AppUser user) {
          _stopAnimation('login');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => HomePage()));

        },
        fail: (error) {
          _stopAnimation('login');
          if(error.toString().startsWith('[firebase_auth/user-not-found]')){
            _showMessage(S.of(context).restPasswordError, context);
          }else if(error.toString().startsWith('[firebase_auth/wrong-password]')){
            _showMessage(S.of(context).wrongPassword, context);
          }else{
            _showMessage(error.toString(), context);
          }

        },
        platformException: (error) {
          _stopAnimation('login');
          _showMessage(error.toString(), context);
        });

  }
}
