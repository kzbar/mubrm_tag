import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:qr_flutter/qr_flutter.dart';
/// QR Code page
class GenerateScreen extends StatefulWidget {
  final String id;

  const GenerateScreen({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {

  GlobalKey globalKey = new GlobalKey();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).generateQR),
        actions: <Widget>[
        ],
      ),
      body: _contentWidget(),
    );
  }


  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
         // HeaderItemIcon(media: media,),
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: 'https://mubrmtag.com/#/${widget.id}',
                  size: 0.5 * bodyHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
