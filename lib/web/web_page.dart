import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:mubrm_tag/widgets/header_item_icons.dart';
import 'package:url_launcher/url_launcher.dart';
class WebPage extends StatefulWidget {
  final String accountId;

  const WebPage({Key key, this.accountId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _WebPage();
  }
}

//https://mubrm-tag.web.app/#/goTo?account_id=NJ8kL1wsm2hFmRFVX7uCcicLHQS2
class _WebPage extends State<WebPage>  with TickerProviderStateMixin{
  String errorMessage = 'ERROR TO OPEN';
  AnimationController _loginButtonController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 900,
            decoration: kBoxDecoration,
          ),
          widget.accountId != null
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.accountId)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        AppUser user = AppUser.fromFireStoreDataBase(snapshot.data.data());
                        SocialMedia media = SocialMedia.fromJson(user.socialMediaSelected);
                        return Center(
                          child: Column(
                            children: [
                              Container(
                                child: HeaderItemIcon(media: media,),margin: EdgeInsets.only(top: 48,bottom: 24),),
                              InkWell(
                                onTap: () {
                                  _launchURL('${media.socialLinkWeb}${media.value}');
                                },
                                child: StaggerAnimation(
                                  buttonController: _loginButtonController.view,
                                  titleButton: 'OPEN'),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                            child: CircularProgressIndicator(strokeWidth: 1,),
                          ),
                        );
                      }
                    } else {
                      return Container(
                        child: Text(
                          errorMessage,
                          style: kTextStyleTile.copyWith(color: Colors.white),
                        ),
                      );
                    }
                  },
                )
              : Container(
                  child: Text(
                    'NO ACCOUNT ID',
                    style: kTextStyleTile.copyWith(color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }

@override
  void initState() {
  _loginButtonController = AnimationController(
      duration: Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    Future.delayed(Duration(seconds: 1),() async{
     await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountId)
          .get().then((value) {
        AppUser user = AppUser.fromFireStoreDataBase(value.data());
        SocialMedia media = SocialMedia.fromJson(user.socialMediaSelected);
         _launchURL('${media.socialLinkWeb}${media.value}');
      });
    });
    super.didChangeDependencies();
  }

  _launchURL(data) async {

    if (await canLaunch(data)) {
      try {
        await launch(
          data,
          forceSafariVC: true,
        );
      } catch (error) {
        setState(() {
          errorMessage = error;
        });
      }
    } else {
      await launch(data, forceSafariVC: true,enableDomStorage: true,universalLinksOnly: true,enableJavaScript: true);
      setState(() {
        errorMessage = 'Could not launch $data';
      });
      throw 'Could not launch $data';
    }
  }
}
