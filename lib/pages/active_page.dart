import 'package:flutter/material.dart';
import 'package:mubrm_tag/anim/sprite_painter.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/widgets/button_animation.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivePage();
  }
}

class _ActivePage extends State<ActivePage>
    with SingleTickerProviderStateMixin {
  bool _supportsNFC = false;
  bool isScan = false;
  bool wrote = false;
  String url = '';
  Future<String> phoneNumber;
  Future<bool> hasWrote;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AnimationController _loginButtonController;

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;

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
                    S.of(context).activeMubrm,
                    style: kTextStyleTile,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    _supportsNFC
                        ? S.of(context).deviceSupportApp
                        : S.of(context).deviceNotSupportApp,
                    style: kTextStyle.copyWith(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 24),
                  child: InkWell(
                    onTap: () {
                      _playAnimation();
                      Stream<NDEFMessage> _stream = NFC.readNDEF();
                      _stream.listen((event) {
                        event.records.map((element) {
                          setState(() {});
                          print(element);
                        }).toList();
                      });

                      NDEFMessage newMessage = NDEFMessage.withRecords([
                        NDEFRecord.uri(Uri.parse(
                            'https://mubrm-tag.web.app/#/goTo?account_id=${user.id}'))
                      ]);
                      Stream<NDEFTag> stream = NFC.writeNDEF(newMessage,
                          once: true,
                          readerMode: NFCNormalReaderMode(noSounds: false));
                      stream.listen((NDEFTag tag) {

                        print('Has Wrote');
                        setWrote(
                            'https://mubrm-tag.web.app/#/goTo?account_id=${user.id}');
                        _stopAnimation();
                      });
                      //
                    },
                    child: StaggerAnimation(
                      begin: 300,
                      buttonController: _loginButtonController.view,
                      titleButton: wrote
                          ? S.of(context).accountActive
                          : S.of(context).accountNotActive,
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
    AppUser user = Provider.of<UserModel>(context, listen: false).userApp;
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
    Future.delayed(Duration.zero, () async {
      hasWrote = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('hasWroteAccount') ?? false);
      });
      wrote = await hasWrote;
      phoneNumber = _prefs.then((SharedPreferences prefs) {
        return (prefs.getString('url') ?? null);
      });
      url = await phoneNumber;
    });
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    super.initState();
  }

  setWrote(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasWroteAccount', true);
    await prefs.setString('url', url);
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
      });
    } on TickerCanceled {
      printLog('_stopAnimation', ' error');
    }
  }
}
