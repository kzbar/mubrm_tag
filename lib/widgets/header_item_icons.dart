


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/model/social_media.dart';

class HeaderItemIcon extends StatelessWidget {
 final SocialMedia media;
 final bool withFilter ;

  const HeaderItemIcon({Key key, this.media, this.withFilter = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(media.socialIsSelect);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent
      ),

      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.only(left: 24,right: 24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child:  Stack(
              children: [
                Image.asset('images/PNG/${media.socialIcon}.png',width: 120,height: 120,),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,

                  ),

                )
              ],
            )
          ),

          Container(
            child: Text(media.socialName ?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
            margin: EdgeInsets.only(top: 6),
          )
        ],
      ),
    );
  }

}