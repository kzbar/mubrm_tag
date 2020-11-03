import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mubrm_tag/anim/sprite_painter.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivePagePhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivePage();
  }
}

class _ActivePage extends State<ActivePagePhone>
    with SingleTickerProviderStateMixin {
  bool _supportsNFC = false;
  String phone;
  String buttonName = 'تفعيل الرقم';
  bool isScan = false;
  AnimationController _loginButtonController;
  Future<String> phoneNumber;
  Future<bool> hasWrote;
  bool wrote = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'تفعيل MUBRM',
                    style: kTextStyleTile,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    _supportsNFC
                        ? S.of(context).deviceSupportApp
                        : Platform.isAndroid
                            ? S.of(context).deviceNotSupportApp
                            : S.of(context).deviceNotSupportAppIos,
                    style: kTextStyle.copyWith(color: Colors.white),
                  ),
                ),
                Visibility(
                  visible: !isScan,
                  child: Container(
                    margin: EdgeInsets.only(top: 48),
                    child: Text(
                      wrote
                          ? S
                              .of(context)
                              .phoneNumberIs(controller.text.toString())
                          : "",
                      style: kTextStyle.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                FormBuilder(
                  key: _fbKey,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 24, right: 24, bottom: 24, top: 48),
                    padding: EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    height: 50,
                    decoration: kBoxDecorationEditText,
                    child: FormBuilderTextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      validators: [
                        FormBuilderValidators.required(
                            errorText: S.of(context).errorTextRequired),
                      ],
                      attribute: 'phoneNumber',
                      decoration: InputDecoration(
                          hintText: S.of(context).phoneNumber,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Visibility(
                  visible: _supportsNFC,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 24, right: 24, bottom: 24, top: 24),
                    child: InkWell(
                      onTap: () {
                        _fbKey.currentState.save();
                        if (_fbKey.currentState.validate()) {
                          _playAnimation();
                          Stream<NDEFMessage> _stream = NFC.readNDEF();

                          _stream.listen((event) {
                            try{
                              NDEFMessage newMessage = NDEFMessage.withRecords([
                                NDEFRecord.uri(Uri.parse(
                                    'tel:${_fbKey.currentState.value['phoneNumber']}'))
                              ]);
                              event.tag.write(newMessage);

                            }on PlatformException catch (error){
                              print(error.message);
                              _stopAnimation();
                            }
                            event.records.map((element) {
                              setState(() {
                                phone =
                                    element.data.substring(3).trim().toString();
                              });
                              print(element.data);
                            }).toList();
                          });

                          NDEFMessage newMessage = NDEFMessage.withRecords([
                            NDEFRecord.uri(Uri.parse(
                                'tel:${_fbKey.currentState.value['phoneNumber']}'))
                          ]);
                          Stream<NDEFTag> stream = NFC.writeNDEF(newMessage,
                              once: true,
                              readerMode: NFCNormalReaderMode(noSounds: false));
                          stream.listen((NDEFTag tag) {
                            print('Has Wrote');
                            setWrote(
                                'tel:${_fbKey.currentState.value['phoneNumber']}');
                            _stopAnimation();
                          });
                        }
                        //
                      },
                      child: StaggerAnimation(
                        buttonController: _loginButtonController.view,
                        titleButton: wrote
                            ? S.of(context).editPhoneNumber
                            : S.of(context).phoneNumberSuccess,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  width: 400,
                  child: Visibility(
                    visible: isScan,
                    child: Column(
                      children: [
                        SpriteDemo(),
                        Container(
                          child: Text(
                            S.of(context).messageToHold,
                            style: kTextStyle.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          margin: EdgeInsets.only(left: 48, right: 48),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      hasWrote = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('hasWrote') ?? false);
      });
      wrote = await hasWrote;
      phoneNumber = _prefs.then((SharedPreferences prefs) {
        return (prefs.getString('phoneNumber') ?? null);
      });
      phone = await phoneNumber;
      if (phone != null) {
        controller.text = phone.substring(4, phone.length);
      }
    });

    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });

    super.initState();
  }

  setWrote(phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasWrote', true);
    await prefs.setString('phoneNumber', phone);
    setState(() {
      wrote = true;
      controller.text = phone.toString().substring(4, phone.toString().length);
    });
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isScan = true;
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
        isScan = false;
        buttonName = S.of(context).phoneNumberSuccess;
      });
    } on TickerCanceled {
      printLog('_stopAnimation', ' error');
    }
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }
}
