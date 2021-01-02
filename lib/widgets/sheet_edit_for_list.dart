import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/model/social_media.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SheetEditForSocialList extends StatefulWidget {
  final SocialMedia media;
  final bool newAdd;
  final SocialMedia lastMediaSelected;

  const SheetEditForSocialList(
      {Key key, this.media, this.newAdd, this.lastMediaSelected})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SheetEdit();
  }
}

class _SheetEdit extends State<SheetEditForSocialList> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController controller = TextEditingController();
  String messageError = '';
  @override
  void initState() {
    setState(() {
      controller.text = widget.media.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;
    String lang = Provider.of<ModelApp>(context, listen: false).locale;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection('socialMediaSelectedList')
          .doc(widget.media.firebaseId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> map = snapshot.data.data() ?? null;
          SocialMedia me;
          if (map != null) {
            me = SocialMedia.fromJsonFireStore(
                snapshot.data.data(), snapshot.data.id);
          } else {
            me = widget.media;
          }
          return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24, right: 24, left: 24),
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      IconButton(
                        focusColor: Colors.grey.shade300,
                        icon: Icon(
                          Icons.close_sharp,
                          size: 36,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Visibility(
                        visible: !widget.newAdd,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/PNG/share.png',
                                  width: 36,
                                  height: 36,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              onTap: () {
                                share(
                                    ref: S
                                        .of(context)
                                        .shareMyAccountSocialMessage(
                                            '${me.socialLinkWeb}${me.value}'),
                                    context: context);
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                S
                                    .of(context)
                                    .shareMyAccountSocial(me.socialName),
                                style: kTextStyle.copyWith(
                                    color: Colors.black, fontSize: 10),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    S.of(context).enterYourLink,
                    style: kTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        'images/PNG/${widget.media.socialIcon}.png',
                        width: 36,
                        height: 36,
                      ),
                      Expanded(
                        child: FormBuilder(
                          key: _fbKey,
                          child: Container(
                            margin: EdgeInsets.only(left: 12, right: 12),
                            child: FormBuilderTextField(
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: 'هذا الحقل فارغ يرجى ملئ الحقل'),
                              ],
                              style: kTextStyleEditText,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              attribute: 'value',
                              controller: controller,
                              // initialValue: widget.media.value,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.clear_rounded),
                          onPressed: () {
                            SocialMedia media = SocialMedia(
                              socialName: widget.media.socialName,
                              id: widget.media.id,
                              socialIcon: widget.media.socialIcon,
                              socialIsSelect: false,
                              socialAddedTo: true,
                              socialLinkAndroid: widget.media.socialLinkAndroid,
                              socialLinkWeb: widget.media.socialLinkWeb,
                              socialLinkIos: widget.media.socialLinkIos,
                              messageAR: widget.media.messageAR,
                              messageEN: widget.media.messageEN,
                              value: null,
                            );
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.id)
                                .collection('socialMediaSelectedList')
                                .doc(widget.media.firebaseId)
                                .update(media.toJson())
                                .then((value) {
                              setState(() {
                                controller.text = '';
                              });
                            });
                          }),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                  child: Text(
                    lang == 'ar' ? me.messageAR : me.messageEN,
                    style: kTextStyle.copyWith(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                  child: Row(
                    children: [
                      Expanded(
                          child: FlatButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _fbKey.currentState.save();
                          if (_fbKey.currentState.validate()) {
                            SocialMedia media = SocialMedia(
                              firebaseId: widget.media.firebaseId,
                              socialName: widget.media.socialName,
                              id: widget.media.id,
                              socialIcon: widget.media.socialIcon,
                              socialIsSelect: false,
                              socialAddedTo: true,
                              socialLinkAndroid: widget.media.socialLinkAndroid,
                              socialLinkWeb: widget.media.socialLinkWeb,
                              socialLinkIos: widget.media.socialLinkIos,
                              messageAR: widget.media.messageAR,
                              messageEN: widget.media.messageEN,
                              value: _fbKey.currentState.value['value'],
                            );
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.id)
                                .collection('socialMediaSelectedList')
                                .doc(widget.media.firebaseId)
                                .update(media.toJson())
                                .then((value) {
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Text(
                          S.of(context).save,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      SizedBox(
                        width: widget.newAdd ? 0 : 12,
                      ),
                      !widget.newAdd
                          ? Expanded(
                              child: FlatButton(
                              color: Colors.grey.shade800,
                              onPressed: () {
                                delete(context, user, me);
                              },
                              child: Text(S.of(context).delete,
                                  style: TextStyle(color: Colors.white)),
                            ))
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 24, right: 24, top: 12),
                  child: Row(
                    children: [
                      Expanded(
                          child: FlatButton(
                        color: Colors.greenAccent,
                        onPressed: () {
                          _fbKey.currentState.save();
                          if (_fbKey.currentState.validate()) {
                            String value = _fbKey.currentState.value['value'];
                            _launchURL('${me.socialLinkWeb}$value');
                          }
                        },
                        child: Text(
                          S.of(context).openAccount,
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                    ],
                  ),
                ),
                Visibility(
                    visible: !widget.newAdd,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 24, right: 24, top: 12),
                      child: Row(
                        children: [
                          Expanded(
                              child: FlatButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              _fbKey.currentState.save();
                              if (_fbKey.currentState.validate()) {
                                SocialMedia media = SocialMedia(
                                  socialName: widget.media.socialName,
                                  id: widget.media.id,
                                  socialIcon: widget.media.socialIcon,
                                  socialIsSelect: true,
                                  socialAddedTo: true,
                                  socialLinkAndroid:
                                      widget.media.socialLinkAndroid,
                                  socialLinkWeb: widget.media.socialLinkWeb,
                                  socialLinkIos: widget.media.socialLinkIos,
                                  value: _fbKey.currentState.value['value'],
                                  messageAR: widget.media.messageAR,
                                  messageEN: widget.media.messageEN,
                                );
                                SocialMedia last = SocialMedia(
                                  socialName:
                                      widget.lastMediaSelected.socialName,
                                  id: widget.lastMediaSelected.id,
                                  socialIcon:
                                      widget.lastMediaSelected.socialIcon,
                                  socialIsSelect: false,
                                  socialAddedTo: true,
                                  socialLinkAndroid: widget
                                      .lastMediaSelected.socialLinkAndroid,
                                  socialLinkWeb:
                                      widget.lastMediaSelected.socialLinkWeb,
                                  socialLinkIos:
                                      widget.lastMediaSelected.socialLinkIos,
                                  value: _fbKey.currentState.value['value'],
                                  messageAR: widget.lastMediaSelected.messageAR,
                                  messageEN: widget.lastMediaSelected.messageEN,
                                );
                                setMediaDefault(user, media, last)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                            child: Text(
                              S.of(context).setDef,
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                        ],
                      ),
                    )),
                Container(
                  child: Text(
                    messageError,
                    style: kTextStyle.copyWith(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  delete(context, AppUser office, SocialMedia media) async {
    Widget dialog = Platform.isAndroid
        ? AlertDialog(
            title: Text(
              'تنبيه',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Text('هل تريد حذف هذا الحساب من القائمة !!'),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await deleteSocial(office.id, media).then((value) {
                    Navigator.pop(context);
                  });
                },
                child:
                    Text('نعم', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    Text('لا', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(
              "تنييه",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Text('هل تريد حذف هذا الحساب من القائمة !!'),
            actions: <Widget>[
              CupertinoButton(
                child: Text('نعم'),
                onPressed: () async {
                  Navigator.pop(context);
                  await deleteSocial(office.id, media).then((value) {
                    Navigator.pop(context);
                  });
                },
              ),
              CupertinoButton(
                child: Text('لا'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
    showDialog(
        context: context, builder: (_) => dialog, barrierDismissible: false);
  }

  _launchURL(data) async {
    if (await canLaunch(data)) {
      try {
        await launch(data);
      } catch (error) {
        throw 'Could not launch $data';

        setState(() {});
      }
    } else {
      await launch(data);
      throw 'Could not launch $data';
    }
  }

  Future<void> deleteSocial(userId, SocialMedia media) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('socialMediaSelectedList')
        .where('socialName', isEqualTo: media.socialName)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await element.reference.update({'socialAddedTo': false});
      });
    });
  }

  Future<void> setMediaDefault(
      AppUser user, SocialMedia media, SocialMedia lastMedia) async {
    List<SocialMedia> list = [];
    list.add(media);
    list.add(lastMedia);

    // list.map((e) async {
    //   print(e.firebaseId);
    //   return await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(user.id).collection('socialMediaSelectedList').doc(e.firebaseId)
    //       .update(e.toJson());
    // }).toList();

    Map<String, dynamic> socialMediaSelected = {
      'socialMediaSelected': media.toJson()
    };

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update(socialMediaSelected);
  }
}
