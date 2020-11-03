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

class _WebPage extends State<WebPage> with TickerProviderStateMixin {
  String errorMessage = 'ERROR TO OPEN';
  AnimationController _loginButtonController;
  List<SocialMedia> _list = [];

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
                  future: getUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<AppUser> snapshot) {
                    if (!snapshot.hasError)
                    {
                      if (snapshot.hasData)
                      {
                        AppUser user = snapshot.data;
                        SocialMedia media =
                            SocialMedia.fromJson(user.socialMediaSelected);
                        return user.profileIsPublic
                            ? profilePublic(user)
                            : profilePrivate(media);
                      } else {
                        return Center(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Image.asset(
                                      'images/PNG/logo.png',
                                      width: 200,
                                      height: 150,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: CircularProgressIndicator(strokeWidth: 4,),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    else {
                      return Container(
                        child: Text(
                          errorMessage,
                          style: kTextStyleTile.copyWith(color: Colors.white),
                        ),
                      );
                    }
                  },
                )
              : Center(
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Image.asset(
                        'images/PNG/logo.png',
                        width: 200,
                        height: 150,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'User Not Found',
                      style: kTextStyle.copyWith(
                          color: Colors.white),
                    ),
                  )
                ],
              ),
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

  Future<AppUser> getUser() async {
    AppUser user;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('nameId', isEqualTo: widget.accountId)
          .get()
          .then((value) {
        value.docs.map((e) {
          if (e.data()['nameId'] == widget.accountId) {
            user = AppUser.fromFireStoreDataBase(e.data());
          }
        }).toList();
      });
      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _launchURL(data) async {
    if (await canLaunch(data.toString())) {
      try {
        await launch(
          data.toString(),
          forceSafariVC: false,
        );
      } catch (error) {
        await launch(data.toString(),
            forceSafariVC: true,
            enableDomStorage: true,
            universalLinksOnly: true,
            enableJavaScript: true);

        setState(() {
          errorMessage = error.toString();
        });
      }
    } else {
      await launch(data.toString(),
          forceSafariVC: true,
          enableDomStorage: true,
          universalLinksOnly: true,
          enableJavaScript: true);
      setState(() {
        errorMessage = 'Could not launch';
      });
      throw 'Could not launch $data';
    }
  }

  Widget profilePublic(user) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection('socialMediaSelectedList')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text(''),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          _list = snapshot.data.docs.where((element) {
            return element.data()['socialAddedTo'];
          }).map((e) {
            print(e.id);
            return SocialMedia.fromJsonFireStore(e.data(), e.id);
          }).toList();

          return Column(
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                    'images/PNG/logo.png',
                    width: 200,
                    height: 150,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: 500,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade700,
                                  offset: Offset(1, 0),
                                  blurRadius: 5)
                            ],
                            color: Theme.of(context).primaryColor,
                          ),
                          child: user != null
                              ? ClipOval(
                                  child: Image.network(
                                    user.picture['image'],
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Image.asset('images/PNG/user.png'),
                          padding: EdgeInsets.all(0.0),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            user.name ?? 'وسام الوسام',
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: _list.map((e) {
                            return InkWell(
                              onTap: () {
                                _launchURL('${e.socialLinkWeb}${e.value}');
                              },
                              child: ItemIcon(
                                media: e,
                                withFilter: true,
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          );
        }
      },
    );
  }

  Widget profilePrivate(media) {
    Future.delayed(Duration(seconds: 1), () async {
      //_launchURL('${media.socialLinkWeb}${media.value}');
    });

    return Center(
      child: Column(
        children: [
          Container(
            child: Center(
              child: Image.asset(
                'images/PNG/logo.png',
                width: 200,
                height: 150,
              ),
            ),
          ),
          Container(
            child: HeaderItemIcon(
              media: media,
            ),
            margin: EdgeInsets.only(top: 48, bottom: 24),
          ),
          InkWell(
            onTap: () {
              _launchURL('${media.socialLinkWeb}${media.value}');
              printLog('_launchURL', media.toJson());
            },
            child: StaggerAnimation(
                buttonController: _loginButtonController.view,
                titleButton: 'OPEN'),
          )
        ],
      ),
    );
  }
}

class ItemIcon extends StatelessWidget {
  final SocialMedia media;
  final bool withFilter;

  const ItemIcon({Key key, this.media, this.withFilter = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(media.socialIsSelect);
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      child: Column(
        children: [
          Container(
              width: 120,
              height: 120,
              margin: EdgeInsets.only(left: 24, right: 24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'images/PNG/${media.socialIcon}.png',
                    width: 120,
                    height: 120,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !withFilter
                          ? Colors.white.withOpacity(0.9)
                          : Colors.transparent,
                    ),
                  )
                ],
              )),
          Container(
            child: Text(
              media.socialName ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: !withFilter
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.white),
            ),
            margin: EdgeInsets.only(top: 6, bottom: 6),
          )
        ],
      ),
    );
  }
}
