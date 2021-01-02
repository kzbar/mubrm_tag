import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:mubrm_tag/widgets/header_item_icons.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        AppUser user = snapshot.data;
                        SocialMedia media =
                            SocialMedia.fromJson(user.socialMediaSelected);
                        return user.profileIsPublic
                            ? profilePublic(user, context)
                            : profilePrivate(media, context);
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
                                  child: Text(
                                    '',
                                    style: kTextStyleTile.copyWith(
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
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
                            'Mubrm App',
                            style: kTextStyleTile.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
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
        if (value.docs.isNotEmpty) {
          value.docs.map((e) {
            if (e.data()['nameId'] == widget.accountId) {
              user = AppUser.fromFireStoreDataBase(e.data());
            } else {
              user = null;
            }
          }).toList();
        } else {
          user = null;
        }
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

  launchURL(data, context) async {
    if (await canLaunch(data.toString())) {
      try {
        await launch(
          data.toString(),
        );
      } catch (error) {
        _showMessage(error.toString(), context);
      }
    } else {
      _showMessage(data + "error", context);
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

  Widget profilePublic(user, context) {
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
                                launchURL(
                                    '${e.socialLinkWeb}${e.value}', context);
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

  Widget profilePrivate(media, context) {
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
              launchURL('${media.socialLinkWeb}${media.value}', context);
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
