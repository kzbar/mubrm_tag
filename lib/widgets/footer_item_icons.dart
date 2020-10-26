


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/model/social_media.dart';

class FooterItemIcon extends StatelessWidget {
 final SocialMedia media;
 final bool withFilter ;

  const FooterItemIcon({Key key, this.media, this.withFilter = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent
      ),
      padding: EdgeInsets.all(12),

      child:  Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(12),

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,

        ),
        child:  Image.asset('images/PNG/${media.socialIcon}.png',width: 80,height: 80,),
      ),
    );
  }

}