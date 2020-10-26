


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mubrm_tag/model/social_media.dart';

class ItemIcon extends StatelessWidget {
 final SocialMedia media;
 final bool withFilter ;

  const ItemIcon({Key key, this.media, this.withFilter = false}) : super(key: key);
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
                    color: !withFilter ? Colors.white.withOpacity(0.9) :Colors.transparent,

                  ),

                )
              ],
            )
          ),

          Container(
            child: Text(media.socialName ?? '',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: !withFilter ? Colors.grey.withOpacity(0.5) :Colors.black),),
            margin: EdgeInsets.only(top: 6),
          )
        ],
      ),
    );
  }

}