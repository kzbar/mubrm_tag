


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mubrm_tag/confing/general.dart';
import 'package:mubrm_tag/generated/l10n.dart';
import 'package:mubrm_tag/models/app_model.dart';
import 'package:mubrm_tag/models/app_user.dart';
import 'package:mubrm_tag/models/user_model.dart';
import 'package:mubrm_tag/widgets/chang_lang.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DrawerWidget extends StatefulWidget{
  final String pageName;
  final ValueChanged changed;


  const DrawerWidget({Key key, this.pageName, this.changed}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DrawerWidget();
  }

}


class _DrawerWidget extends State<DrawerWidget>{
  @override
  void initState() {
    widget.changed(true);
    super.initState();
  }
  @override
  void dispose() {
    widget.changed(false);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<UserModel>(context,listen: false).userApp;
    String lang = Provider.of<ModelApp>(context,listen: false).locale;
   var kListMenu = [
      {'icon': 'home.png', "page": "home_page", "title": S.of(context).mainPage},
      {'icon': 'user.png', "page": "edit_page", "title": S.of(context).myProfile},
      {'icon': 'icon.png', "page": "active_page", "title": S.of(context).activeMubrm},
      {'icon': 'icon.png', "page": "active_page_phone", "title": S.of(context).activeMubrmPhone},
      {'icon': 'share.png', "page": "share", "title": S.of(context).shareApp},
      {'icon': 'exit.png', "page": "exit", "title": S.of(context).exit},
    ];

    return Container(
      margin: EdgeInsets.only(right: lang == 'ar'? 0:100,top: 70,bottom: 48,left: lang == 'ar'?100:0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
          gradient: LinearGradient(colors: <Color>[color1, color2]),
          borderRadius: lang == 'ar' ?BorderRadius.only(topLeft: Radius.circular(30),bottomLeft:Radius.circular(30) ) : BorderRadius.only(topRight: Radius.circular(30),bottomRight:Radius.circular(30) ),

      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 24,top: 24,bottom: 12,right: 24),
            alignment:lang == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              child: Image.asset('images/PNG/cloes.png',height: 36,width: 36,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          ChangeLang(),

          Container(
            margin: EdgeInsets.only(top: 12),
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
              color: Colors.white,
            ),
            child: user != null ? ClipOval(child: Image.network(user.picture['image'],fit: BoxFit.fill,width: 140,height: 140,),) : Image.asset('images/PNG/user.png'),
            padding: EdgeInsets.all(6.0),
          ),
          Expanded(child: Container(
            margin: EdgeInsets.only(top: 24,left: 12,bottom: 12,right: 12),
            child: SingleChildScrollView(
              child: Column(
                children:kListMenu.map((e) {
                  return InkWell(
                    onTap: (){
                      if(widget.pageName != e['page']){
                        if(e['page'] == 'share'){
                          share(ref:'https://play.google.com/store/apps/details?id=com.mubrm_tag',context: context);
                          share(ref:'https://play.google.com/store/apps/details?id=com.mubrm_tag',context: context);
                        }
                        else if(e['page'] == 'exit'){
                          Provider.of<UserModel>(context,listen: false).logOut(success: (s){
                            Navigator.of(context)
                                .pushReplacementNamed(
                              '/login',
                            );

                          });
                        }else{
                          Navigator.popAndPushNamed(context, e['page']);
                        }

                      }else{
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child:Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: widget.pageName == e['page'] ? Colors.black12 : Colors.transparent,
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Image.asset('images/PNG/${e['icon']}',width: 36,height: 36,),
                                Container(
                                    child: Text(e['title'],style: TextStyle(fontSize: 20),),
                                    margin: EdgeInsets.only(left: 12,right: 12)
                                ),

                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12,top: 6.0,left: 6.0,right: 6.0),
                            height: 1,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )),
          Container(
            alignment: lang == 'ar' ? Alignment.centerLeft:  Alignment.centerRight,
            margin: EdgeInsets.only(right: 24,bottom: 24,left: 24),
            child: Image.asset('images/PNG/min_logo.png',width: 100,),
          )
        ],
      ),

    );
  }
  Future share({ref, BuildContext context}) async{
    final ByteData bytes = await rootBundle.load('images/PNG/icon.png');
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(list);

    await Share.shareFiles([
      file.path
    ],text: ref);
    final RenderBox box = context.findRenderObject();
    // await Share.share(ref,
    //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

}