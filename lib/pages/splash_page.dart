import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {
  Future<bool> loggedIn;
  Future<String> lang;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    loggedIn = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('loggedIn') ?? false);
    });
    lang = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('language') ?? 'ar');
    });
    Future.delayed(Duration.zero,() async{
      Provider.of<ModelApp>(context,listen: false).changeLanguage(await lang, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        child: Stack(
          children: [
            Container(
              decoration: kBoxDecoration,
              child: Center(
                child: Image.asset('images/PNG/logo.png',width: 200,height: 150,),
              ),
            ),
            FutureBuilder(
              future: loggedIn,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  Future.delayed(Duration(milliseconds: 1000),()async{
                    if(await loggedIn){
                      Navigator.pushReplacementNamed(context, 'home_page');
                    }else{
                      Navigator.pushReplacementNamed(context, 'login');
                    }
                  });
                }
                return Container();
              }, )
          ],
        ),
      ),
    );
  }
}
