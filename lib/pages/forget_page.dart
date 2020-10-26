import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordPage();
  }
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> with TickerProviderStateMixin{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController _loginButtonController;
  bool emailSend = false;

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    super.initState();
  }
  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String lang = Provider.of<ModelApp>(context,listen: false).locale;

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
                  height: 36,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 12,bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back_ios_sharp,color: Theme.of(context).primaryColor,size: 48,),
                  ),),
                Text(
                  S.of(context).restPassword,
                  style: kTextStyle.copyWith(color: Colors.white,fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, bottom: 24,top: 24),
                  padding: EdgeInsets.only(
                    right: 12,
                    left: 12,
                  ),
                  height: 50,
                  decoration: kBoxDecorationEditText,
                  child: FormBuilderTextField(
                    attribute: 'email',
                    cursorColor: Colors.black,
                    style: kTextStyleEditText,
                    validators: [
                      FormBuilderValidators.required(
                          errorText:
                          S.of(context).errorTextRequired),
                      FormBuilderValidators.email(
                          errorText:
                         S.of(context).errorTextEmail),

                    ],
                    decoration: InputDecoration(
                        hintText: S.of(context).email,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none),
                  ),
                ),
                Visibility(
                  visible: !emailSend,
                  child: InkWell(
                    onTap: (){
                      _fbKey.currentState.save();
                      if(_fbKey.currentState.validate()){
                        _playAnimation();
                        Map<String,dynamic> map = {
                          "lang":lang,
                          'email':_fbKey.currentState.value['email'].toString().trim(),
                        };
                        Provider.of<UserModel>(context,listen: false).forgetPassword(json: map,success: (message){
                          setState(() {
                            emailSend = true;
                          });
                          _showMessage(S.of(context).restPasswordSuccess, context);
                        },fail: (error){
                          _showMessage(S.of(context).restPasswordError, context);

                        },platformException: (error){
                          _showMessage(S.of(context).restPasswordError, context);

                        });
                      }
                    },
                    child: StaggerAnimation(
                      buttonController: _loginButtonController.view,
                      titleButton: S.of(context).continueTo,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    _stopAnimation();
    final snackBar = SnackBar(
      content: Text(
        '$message !',
        style: kTextStyle,
      ),
    );
    _scaffoldKey.currentState
      ..showSnackBar(snackBar);
  }

}
