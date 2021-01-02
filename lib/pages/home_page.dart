import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generate/generate_qr.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/services/firebase_provider.dart';
import 'package:mubrm_tag/widgets/drawer_widget.dart';
import 'package:mubrm_tag/widgets/footer_item_icons.dart';
import 'package:mubrm_tag/widgets/header_item_icons.dart';
import 'package:mubrm_tag/widgets/list_item_icons.dart';
import 'package:mubrm_tag/widgets/list_item_icons_add_link.dart';
import 'package:mubrm_tag/widgets/sheet_edit_for_header.dart';
import 'package:mubrm_tag/widgets/sheet_edit_for_list.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Animation<Offset> offsetTop;
  AnimationController controller;
  Animation<double> menuAnimation;
  AnimationController menuController;
  SocialMedia currentMedia;
  Map<String, dynamic> header;
  List<SocialMedia> _list = [];

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    offsetTop = Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
        .animate(controller);
    Future.delayed(Duration(milliseconds: 300), () {
      controller.forward();
    });
    menuController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    menuAnimation =
        Tween<double>(begin: 0.0, end: 0.25).animate(menuController);

    super.initState();
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;
    FirebaseProvider.listenToMedias((newMessage) {
      currentMedia = newMessage;
    }, user.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;

    void _onReorder(int oldIndex, int newIndex) async {}
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        changed: (isOpen) {
          !isOpen ? menuController.reverse() : menuController.forward();
        },
        pageName: 'home_page',
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 70),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0))),
          ),
          SlideTransition(
            position: offsetTop,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(bottom: 70, top: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 60),
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
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.id)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.data.data() != null) {
                          Map<String, dynamic> map =
                              snapshot.data.data()['socialMediaSelected'] ?? {};
                          if (map != null) {
                            SocialMedia me = SocialMedia.fromJsonFireStore(
                                map, snapshot.data.id);
                            return InkWell(
                              child: HeaderItemIcon(
                                media: me,
                              ),
                              onTap: () {
                                showSheet(context, me, false, user);
                              },
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 6, bottom: 24),
                              child: Text(
                                'لا يوجد حساب افتراضي حدد حساب الآن',
                                style: kTextStyle.copyWith(color: Colors.red),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.id)
                          .collection('socialMediaSelectedList')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          _list = snapshot.data.docs.where((element) {
                            return element.data()['socialAddedTo'] &&
                                element.data()['id'] != currentMedia.id;
                          }).map((e) {
                            print(e.id);
                            return SocialMedia.fromJsonFireStore(
                                e.data(), e.id);
                          }).toList();
                          return ReorderableWrap(
                              needsLongPressDraggable: false,
                              buildDraggableFeedback: (context, cox, child) {
                                return Material(
                                  color: Colors.transparent,
                                  child: child,
                                );
                              },
                              footer: InkWell(
                                onTap: () {
                                  showSheetAddLink(context, user);
                                },
                                child: FooterItemIcon(
                                  media: SocialMedia.fromJson(kFooterIcon),
                                ),
                              ),
                              runSpacing: 12,
                              spacing: 36,
                              alignment: WrapAlignment.center,
                              onReorder: _onReorder,
                              children: _list.isNotEmpty
                                  ? _list.map((e) {
                                      SocialMedia me = e;
                                      return InkWell(
                                        key: ObjectKey(me),
                                        onTap: () {
                                          showSheetForList(context, me, false,
                                              user, currentMedia);
                                        },
                                        child: ItemIcon(
                                          media: me,
                                          withFilter: user.profileIsPublic
                                              ? true
                                              : me.socialIsSelect,
                                        ),
                                      );
                                    }).toList()
                                  : []);
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
                    ),
                    SizedBox(
                      height: 48,
                    )
                  ],
                ),
              ),
            ),
          ),
          //Top page
          Positioned(
              top: 48,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: RotationTransition(
                        turns: menuAnimation,
                        child: Container(
                          margin: EdgeInsets.only(left: 24, right: 24),
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'images/PNG/menu.png',
                            width: 48,
                            height: 48,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 12, left: 12),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/PNG/share.png',
                                width: 48,
                                height: 48,
                              ),
                            ),
                            onTap: () {
                              share(
                                  ref: 'https://mubrmtag.com/#/${user.nameId}',
                                  context: context);
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            child: Text(
                              S.of(context).shareMyAccount,
                              style: kTextStyle.copyWith(
                                  color: Colors.black, fontSize: 10),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ],
                ),
              )),
          //bottom page
          Positioned(
              bottom: 15,
              left: 50,
              right: 50,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1, 0),
                                      blurRadius: 5)
                                ],
                                color: Colors.grey.shade400),
                            padding: EdgeInsets.all(6.0),
                            width: 75,
                            height: 75,
                            margin: EdgeInsets.only(left: 24, right: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              padding: EdgeInsets.all(12.0),
                              child: Image.asset('images/PNG/srq.png'),
                            ),
                          ),
                          Text(
                            S.of(context).barcode,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenerateScreen(
                                    id: user.nameId,
                                  )),
                        );
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            padding: EdgeInsets.all(6.0),
                            margin: EdgeInsets.only(left: 24, right: 24),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1, 0),
                                      blurRadius: 5)
                                ],
                                color: Colors.grey.shade400),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset('images/PNG/add.png'),
                            ),
                          ),
                          Text(
                            S.of(context).addLink,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      onTap: () async {
                        showSheetAddLink(context, user);
                      },
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void showSheetForList(context, SocialMedia _media, bool newAdd, AppUser user,
      SocialMedia last) {
    print(_media.toRawJson());
    _scaffoldKey.currentState.showBottomSheet((context) {
      return SheetEditForSocialList(
        media: _media,
        newAdd: newAdd,
        lastMediaSelected: last,
      );
    });
  }

  void showSheet(context, SocialMedia _media, bool newAdd, AppUser user) {
    print(_media.toRawJson());
    _scaffoldKey.currentState.showBottomSheet((context) {
      return SheetEditForSocialMediaSelected(
        media: _media,
      );
    });
  }

  void showSheetAddLink(context, user) {
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24, right: 24),
              alignment: Alignment.centerRight,
              child: IconButton(
                focusColor: Colors.grey.shade300,
                icon: Icon(
                  Icons.close_sharp,
                  size: 36,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6, bottom: 24),
              child: Text(
                S.of(context).addLink,
                style: kTextStyle,
              ),
            ),
            Expanded(
                child: Container(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.id)
                    .collection('socialMediaSelectedList')
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        SocialMedia me = SocialMedia.fromJsonFireStore(
                            snapshot.data.docs[index].data(),
                            snapshot.data.docs[index].id);
                        return InkWell(
                          onTap: () async {
                            if (!me.socialAddedTo) {
                              Navigator.of(context).pop();
                              showSheetForList(
                                  context, me, true, user, currentMedia);
                            }
                          },
                          child: ItemIconAddLink(
                            media: me,
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                    );
                  } else {
                    return Container(
                      child: Text('No items'),
                    );
                  }
                },
              ),
              margin: EdgeInsets.only(left: 12, right: 12),
            ))
          ],
        ),
      );
    });
  }
}
